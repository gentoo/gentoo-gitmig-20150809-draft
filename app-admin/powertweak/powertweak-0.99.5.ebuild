# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.99.5.ebuild,v 1.1 2003/08/16 06:33:09 vapier Exp $

inherit eutils

DESCRIPTION="Tune your kernel and hardware settings for optimal performance"
HOMEPAGE="http://powertweak.sourceforge.net/"
SRC_URI="mirror://sourceforge/powertweak/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/libxml2-2.3.0
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND=">=sys-apps/pciutils-2.1.0
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	econf `use_enable gtk gtktest` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	docinto Documentation
	dodoc Documentation/* Documentation/Hackers/*

	use gtk || rm ${D}/usr/bin/gpowertweak

	exeinto /etc/init.d ; newexe ${FILESDIR}/powertweakd.rc6 powertweakd
}
