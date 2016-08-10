# --
# ExternalSupplierForwarding.pm - code run during package de-/installation
# Copyright (C) 2006-2016 c.a.p.e. IT GmbH, http://www.cape-it.de
#
# written/edited by:
# * Frank(dot)Oberender(at)cape(dash)it(dot)de
#
# --
# $Id$
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::packagesetup::ExternalSupplierForwarding;

use strict;
use warnings;

use vars qw(@ISA $VERSION);
$VERSION = qw($Revision$) [1];

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::SysConfig',
    'Kernel::System::Package',
);

=head1 NAME

OTRS_CiCS.pm - code to excecute during package installation

=head1 SYNOPSIS

All functions

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

create an object

    use Kernel::Config;
    use Kernel::System::Log;
    use Kernel::System::Main;
    use Kernel::System::Time;
    use Kernel::System::DB;
    use Kernel::System::XML;

    my $ConfigObject = Kernel::Config->new();
    my $LogObject    = Kernel::System::Log->new(
        ConfigObject => $ConfigObject,
    );
    my $MainObject = Kernel::System::Main->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
    );
    my $TimeObject = Kernel::System::Time->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
    );
    my $DBObject = Kernel::System::DB->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        MainObject   => $MainObject,
    );
    my $XMLObject = Kernel::System::XML->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        DBObject     => $DBObject,
        MainObject   => $MainObject,
    );
    my $CodeObject = var::packagesetup::OTRS-CiCS-ITSM.pm->new(
        ConfigObject => $ConfigObject,
        LogObject    => $LogObject,
        MainObject   => $MainObject,
        TimeObject   => $TimeObject,
        DBObject     => $DBObject,
        XMLObject    => $XMLObject,
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item CodeInstall()

run the code install part

    my $Result = $CodeObject->CodeInstall();

=cut

sub CodeInstall {
    my ( $Self, %Param ) = @_;

    if ( $Kernel::OM->Get('Kernel::System::Package')->PackageIsInstalled( Name => 'KIX4OTRS' ) ) {
        $Self->_EditArticleTypeIcons( Install => 1 );
    }

    return 1;
}

=item CodeReinstall()

run the code reinstall part

    my $Result = $CodeObject->CodeReinstall();

=cut

sub CodeReinstall {
    my ( $Self, %Param ) = @_;

    if ( $Kernel::OM->Get('Kernel::System::Package')->PackageIsInstalled( Name => 'KIX4OTRS' ) ) {
        $Self->_EditArticleTypeIcons( Install => 1 );
    }

    return 1;
}

=item CodeUpgrade()

run the code upgrade part

    my $Result = $CodeObject->CodeUpgrade();

=cut

sub CodeUpgrade {
    my ( $Self, %Param ) = @_;

    if ( $Kernel::OM->Get('Kernel::System::Package')->PackageIsInstalled( Name => 'KIX4OTRS' ) ) {
        $Self->_EditArticleTypeIcons( Install => 1 );
    }

    return 1;
}

=item CodeUninstall()

run the code uninstall part

    my $Result = $CodeObject->CodeUninstall();

=cut

sub CodeUninstall {
    my ( $Self, %Param ) = @_;

    if ( $Kernel::OM->Get('Kernel::System::Package')->PackageIsInstalled( Name => 'KIX4OTRS' ) ) {
        $Self->_EditArticleTypeIcons();
    }

    return 1;
}

=item _EditArticleTypeIcons()

add EditArticleTypeIcons for Hash and Arrays

    my $Result = $CodeObject->_EditArticleTypeIcons(
        Install  => 0|1
    );
    
    * if Install=1 values will be added 
    * if Install=0 values will be delete 
=cut

sub _EditArticleTypeIcons {
    my ( $Self, %Param ) = @_;

    my $SysConfigEntry             = 'Ticket::ArticleTypeIcon';
    my %AdditionalArticleTypeIcons = (
        'note-supplier-external' => 'note-supplier-external.png',
        'note-supplier-internal' => 'note-supplier-internal.png'
    );

    for my $ArticleType ( keys %AdditionalArticleTypeIcons ) {
        if ( $Param{Install} ) {
            $Self->_AddSysConfigValue(
                Name  => $SysConfigEntry,
                Key   => $ArticleType,
                Value => $AdditionalArticleTypeIcons{$ArticleType},
            );
        }
        else {
            $Self->_DelSysConfigValue(
                Name => $SysConfigEntry,
                Key  => $ArticleType,
            );
        }
    }
}

=item _AddSysConfigValue()

add SysConfigValue for Hash and Arrays

    my $Result = $CodeObject->_AddSysConfigValue(
        Name  => 'Tool::Acknowledge::FreeField::Host1'
        Key   => 'xyz' # only vor Hashes
        Value => '123'
    );

=cut

sub _AddSysConfigValue {
    my ( $Self, %Param ) = @_;

    return if ( !$Param{Name} );

    my $SysConfigVal = '';
    if ( $Param{Name} =~ /###/ ) {
        my @SysConfigObject = split( /###/, $Param{Name} );
        my $SysConfigObj = $Kernel::OM->Get('Kernel::Config')->Get( $SysConfigObject[0] );
        if ( $SysConfigObj && ref($SysConfigObj) && $SysConfigObj->{ $SysConfigObject[1] } ) {
            $SysConfigVal = $SysConfigObj->{ $SysConfigObject[1] };
        }
    }
    else {
        $SysConfigVal = $Kernel::OM->Get('Kernel::Config')->Get( $Param{Name} );
    }

    return if ( !$SysConfigVal );

    my $ObjectType = ref($SysConfigVal) || '';

    return if ( !$ObjectType && ( $ObjectType ne 'HASH' && $ObjectType ne 'ARRAY' ) );
    return if ( $ObjectType eq 'HASH' && ( !$Param{Key} || !defined( $Param{Value} ) ) );
    return if ( $ObjectType eq 'ARRAY' && !$Param{Value} );

    if ( $ObjectType eq 'HASH' ) {
        $SysConfigVal->{ $Param{Key} } = $Param{Value};
    }
    elsif ( $ObjectType eq 'ARRAY' ) {
        push( @{$SysConfigVal}, $Param{Value} );
    }

    my $Result = $Kernel::OM->Get('Kernel::System::SysConfig')->ConfigItemUpdate(
        Valid => 1,
        Key   => $Param{Name},
        Value => $SysConfigVal,
    );

    return 1;
}

=item _DelSysConfigValue()

deletes SysConfigValue for Hash and Arrays

    my $Result = $CodeObject->_AddSysConfigValue(
        Name  => 'Tool::Acknowledge::FreeField::Host1'
        Key   => 'xyz' # only vor Hashes
    );

=cut

sub _DelSysConfigValue {
    my ( $Self, %Param ) = @_;

    return if ( !$Param{Name} );

    my $SysConfigVal = '';
    if ( $Param{Name} =~ /###/ ) {
        my @SysConfigObject = split( /###/, $Param{Name} );
        my $SysConfigObj = $Kernel::OM->Get('Kernel::Config')->Get( $SysConfigObject[0] );
        if ( $SysConfigObj && ref($SysConfigObj) && $SysConfigObj->{ $SysConfigObject[1] } ) {
            $SysConfigVal = $SysConfigObj->{ $SysConfigObject[1] };
        }
    }
    else {
        $SysConfigVal = $Kernel::OM->Get('Kernel::Config')->Get( $Param{Name} );
    }

    return if ( !$SysConfigVal );

    my $ObjectType = ref($SysConfigVal) || '';

    return if ( !$ObjectType && $ObjectType ne 'HASH' );
    return if ( $ObjectType eq 'HASH' && !$Param{Key} );

    if ( $ObjectType eq 'HASH' && $SysConfigVal->{ $Param{Key} } ) {
        delete $SysConfigVal->{ $Param{Key} };
    }

    my $Result = $Kernel::OM->Get('Kernel::System::SysConfig')->ConfigItemUpdate(
        Valid => 1,
        Key   => $Param{Name},
        Value => $SysConfigVal,
    );

    return 1;
}

1;

=back

=head1 TERMS AND CONDITIONS

This Software is part of the OTRS project (http://otrs.org/).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see http://www.gnu.org/licenses/gpl-2.0.txt.

=cut

=head1 VERSION
$Revision$ $Date$
=cut
