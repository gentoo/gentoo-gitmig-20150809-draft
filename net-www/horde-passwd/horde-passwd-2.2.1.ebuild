# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/horde-passwd/horde-passwd-2.2.1.ebuild,v 1.1 2004/08/11 03:17:34 vapier Exp $

inherit horde eutils

DESCRIPTION="Horde Passwd is the Horde password changing application"

KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="clearpasswd"

DEPEND=""
RDEPEND=">=net-www/horde-2.2.4"

src_unpack() {
	horde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${PV}-main.php-typo.patch
	epatch ${FILESDIR}/${PV}-example-backend-setup.patch
	epatch ${FILESDIR}/${PV}-crypt-support.patch
	use clearpasswd || epatch ${FILESDIR}/${PV}-no-clear-password.patch
}
