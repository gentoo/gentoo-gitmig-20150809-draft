# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-imp/horde-imp-3.2.5.ebuild,v 1.1 2004/08/08 06:39:57 vapier Exp $

HORDE_PHP_FEATURES="imap"
inherit horde

DESCRIPTION="Horde IMP provides webmail access to IMAP/POP3 mailboxes"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.5"
