# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.2.3.ebuild,v 1.3 2003/11/16 23:16:09 pyrania Exp $

DESCRIPTION="Qingy is a DirectFB getty replacement."
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="pam"
DEPEND=">=dev-libs/DirectFB-0.9.18
	pam? ( >=sys-libs/pam-0.75-r11 )"
S=${WORKDIR}/${P}

src_compile()
{
	econf || die

	emake || die
}

src_install()
{
	# create some dirs
	mkdir -m 755 ${D}etc
	use pam && mkdir -m 755 ${D}etc/pam.d
	mkdir -m 755 ${D}sbin

	# copy documentation manually as make install doesn't do that
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README HOWTO_THEMES

	# and finally install the program
	make prefix=${D} install || die
}

pkg_postinst ()
{
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check files INSTALL and README in /usr/share/doc/${P}"
	einfo "for instructions on how to do that."
}
