# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.99.5_pre20021029.ebuild,v 1.5 2003/02/11 12:05:34 seemant Exp $

inherit eutils

IUSE="gtk"

S=${WORKDIR}/${PN}
DESCRIPTION="Tune your kernel and hardware settings for optimal performance"
HOMEPAGE="http://powertweak.sourceforge.net/"
SRC_URI="mirror://sourceforge/powertweak/${PN}-0.99.4.tar.bz2
	mirror://gentoo/${P}.diff.bz2
	http://cvs.gentoo.org/~seemant/${P}.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/libxml2-2.3.0
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND=">=sys-apps/pciutils-2.1.0
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${P}.diff

	cp configure.in configure.in.orig
	sed -e "s:CFLAGS=\"\":CFLAGS=\"${CFLAGS}\":" \
		< configure.in.orig > configure.in
}

src_compile() {
	./autogen.sh

	use gtk || myconf="--disable-gtktest" 
	econf ${myconf}
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
