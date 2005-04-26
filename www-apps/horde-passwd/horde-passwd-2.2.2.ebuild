# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-passwd/horde-passwd-2.2.2.ebuild,v 1.1 2005/04/26 02:54:40 vapier Exp $

inherit horde eutils

DESCRIPTION="Horde Passwd is the Horde password changing application"

KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE="clearpasswd"

DEPEND=""
RDEPEND=">=www-apps/horde-2.2.8"

src_unpack() {
	horde_src_unpack
	cd "${S}"
	use clearpasswd || epatch "${FILESDIR}"/2.2.1-no-clear-password.patch
}
