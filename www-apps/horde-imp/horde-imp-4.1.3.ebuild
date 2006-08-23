# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-imp/horde-imp-4.1.3.ebuild,v 1.1 2006/08/23 23:35:41 vapier Exp $

HORDE_PHP_FEATURES="imap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Horde IMP provides webmail access to IMAP/POP3 mailboxes"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="crypt"

DEPEND=""
RDEPEND=">=www-apps/horde-3
	crypt? ( app-crypt/gnupg )"
