# --
# Kernel/Language/de_ExternalSupplierForwarding.pm
# Copyright (C) 2006-2016 c.a.p.e. IT GmbH, http://www.cape-it.de
#
# written/edited by:
# * Anna(dot)Litvinova(at)cape(dash)it(dot)de
# * Stefan(dot)Mehlig(at)cape(dash)it(dot)de
# * Torsten(dot)Thau(at)cape(dash)it(dot)de
# --
# $Id$
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
package Kernel::Language::de_ExternalSupplierForwarding;
use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;
    my $Lang = $Self->{Translation};
    return if ref $Lang ne 'HASH';

    # $$START$$
    $Lang->{'First Customer Article'}        = 'Erste Kundenmeldung';
    $Lang->{'General Ticket Data'}           = 'Allgemeine Vorgangsinformationen';
    $Lang->{'Related CI Data'}               = 'Daten verbundener CIs';
    $Lang->{'Fax to'}                        = 'Telefax an';
    $Lang->{'Order for Incident Processing'} = 'Auftrag zur Bearbeitung';
    $Lang->{'ADDITIONAL NOTE'}     = 'ZUSÄTZLICHE ANMERKUNG';
    $Lang->{'RELATED OBJECT DATA'} = 'DATEN VERKNÜPFTER OBJEKTE';
    $Lang->{'FORM DATA'}           = 'FORMULAR DATEN';
    $Lang->{'CUSTOMER DATA'}       = 'KUNDENDATEN';
    $Lang->{'PROBLEM DESCRIPTION'} = 'PROBLEMBESCHREIBUNG';
    $Lang->{'Sincerly, Yours'}     = 'viele Grüße, Ihr';
    $Lang->{'Ticket Title'}        = 'Tickettitel';
    $Lang->{'Ticket Number'}       = 'Ticketnummer';
    $Lang->{'Ticket information forwarded to external supplier!'} =
        'Ticketinformation an externen Dienstleister gesendet!';
    $Lang->{
        'This issue/information update has automatically been forwarded to you as external supplier for'
        }
        = 'Diese Anfrage/Aktualisierung wurde automatisch an Sie weitergeleitet, als externen Dienstleister für'
        ;
    $Lang->{'NOTE: Please do NOT remove the processing number from your response - Thank you.'}
        = 'NOTIZ: Bitte entfernen Sie die Ticketnummer NICHT aus Ihrer Antwort - Danke.';
    $Lang->{'This issue has automatically been forwarded to you as external supplier for'}
        = 'Diese Anfrage wurde automatisch an Sie weitergeleitet, als externen Dienstleister für';
    $Lang->{'A new information has been added to an issue which has already been forwarded to you.'}
        = 'Eine neue Information wurde zu einem bereits an Sie weitergeleitetes Ticket hinzugefügt.';
    $Lang->{'Class'}                = 'Klasse';
    $Lang->{'CurInciState'}         = 'Zwischenfallsstatus';
    $Lang->{'InciState'}            = 'Akt. Zwischenfallsstatus';
    $Lang->{'DeplState'}            = 'Status';
    $Lang->{'CurDeplState'}         = 'Akt. Status';
    $Lang->{'Print Forward Fax'}    = 'Weiterleitungsfax drucken';
    $Lang->{'Location Information'} = 'Lokationsinformationen';
    $Lang->{'NameShort'}            = 'Name (kurz)';
    $Lang->{'Phone1'}               = 'Telefon 1';
    $Lang->{'Phone2'}               = 'Telefon 2';
    $Lang->{'Further ticket data'}  = 'Weitere Ticketdaten';
    $Lang->{'Defines CI-attributes for CI-Classes which are not forwarded.'}
        = 'Definiert CI-Attribute fuer CI-Klassen, die nicht weitergeleitet werden.';
    $Lang->{'Defines only CI-attributes for CI-Classes which are forwarded.'}
        = 'Definiert nur die CI-Attribute fuer CI-Klassen, die weitergeleitet werden.';
    $Lang->{
        'Defines BCC-Mailaddress for ExternalSupplierForwarding-Submissions - useful for debugging, does not provide separate encryption forr bcc-receipient.'
        }
        = 'Definiert BCC-Mailadresse fuer ExternalSupplierForwarding-Uebermittlungen - nuetzlich zum Debuggen, stellt keine separate Verschluesselung fuer BCC-Empfaenger zur Verfuegung.';
    $Lang->{'Defines the classes of linked object which are relevant to be forwarded (included).'}
        = 'Legt die Klassen der weiterzuleitenden (zu inkludierenden) Objekte fest';
    $Lang->{
        'Defines article types which are forwarded if added to tickets in Fwd-Queues (note-report will NOT be considered!).'
        }
        = 'Definiert Artikeltypen die weiterleitet werden, wenn sie zu Tickets in spez. Queues hinzugefuegt werden (Note-Report wird NICHT beachtet).';
    $Lang->{'Defines PGP-Keys for mail addresses which are not registered in the key.'}
        = 'Definiert PGP-Schluessel fuer Mailadressen die im Schluessel nicht registriert sind.';
    $Lang->{'Defines mapping of OTRS queues to be forwarded and corresponding email-addresses.'}
        = 'Definiert Mapping von weiterzuleitenden OTRS-queues und den entsprechenden Email-Adressen.';
    $Lang->{'Module to decrypt PGP-encrypted mails before any other processing.'}
        = 'Modul zum Entschluesseln von PGP-verschluesselten Emails vor allen weiteren Bearbeitungen.';
    $Lang->{'Ticket-ACL to show/hide ticket action AgentTicketPrintForwardFax.'}
        = 'Ticket-ACL zum Anzeigen/Verstecken von Ticket-Aktion AgentTicketPrintForwardFax.';
    $Lang->{'Workflowmodule which forwards the ticket (1st article) and related CIs.'}
        = 'Workflow-Modul welches das Ticket (1. Artikel) und verknuepfte CIs weiterleitet.';
    $Lang->{'Extended organization description.'} = 'Erweiterte Organisationsbeschreibung.';
    $Lang->{'Defines which ticket dynamic fields are forwarded.'}
        = 'Definiert welche dynamischen Felder weitergeleitet werden.';
    $Lang->{'Defines mapping of OTRS queues to be fax-forwarded and corresponding fax-numbers.'}
        = 'Definiert Mapping von per Fax weiterzuleitenden OTRS-queues und den entsprechenden FAX-Nummern.';
    $Lang->{
        'Frontend module registration for the AgentTicketPrintForwardFax object in the agent interface.'
    } = 'Frontendmodul-Registration des AgentTicketPrintForwardFax-Objekts im Agent-Interface.';
    $Lang->{'Module to show print forward fax link in menu.'}
        = 'Über dieses Modul wird der Weiterleitungs-Fax-Drucken-Link in der Linkleiste der Ticketansicht angezeigt.';
    $Lang->{'Available articles'} = 'Verfügbare Artikel';
    $Lang->{'Article selection for PrintForwardFax'}
        = 'Artikelauswahl für das Weiterleitungsfax';

    $Lang->{'notesupplier-external'} = 'Notiz extern an Dienstleister';
    $Lang->{'notesupplier-internal'} = 'Notiz intern an Dienstleister';

    return 0;

    # $$STOP$$
}
1;
