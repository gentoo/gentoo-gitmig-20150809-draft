# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-passwd/horde-passwd-2.2.1.ebuild,v 1.3 2004/12/24 07:32:30 vapier Exp $

inherit horde eutils

DESCRIPTION="Horde Passwd is the Horde password changing application"

KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="clearpasswd"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.7"

src_unpack() {
	horde_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${PV}-main.php-typo.patch
	epatch ${FILESDIR}/${PV}-example-backend-setup.patch
	epatch ${FILESDIR}/${PV}-crypt-support.patch
	use clearpasswd || epatch ${FILESDIR}/${PV}-no-clear-password.patch
}
