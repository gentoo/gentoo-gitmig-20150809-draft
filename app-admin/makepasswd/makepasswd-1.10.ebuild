# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="Random password generator"

LICENSE="GPL2"

DEPEND=""
RDEPEND="perl"

SRC_URI="http://ftp.debian.org/debian/dists/stable/main/source/admin/makepasswd_${PV}.orig.tar.gz"
SLOT="0"

src_install () {
	into /usr
	dobin makepasswd
	doman makepasswd.1
	dodoc README CHANGES COPYING-2.0
}
