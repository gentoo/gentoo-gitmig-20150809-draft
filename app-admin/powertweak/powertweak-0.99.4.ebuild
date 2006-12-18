# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.99.4.ebuild,v 1.15 2006/12/18 00:49:40 kugelfang Exp $

inherit flag-o-matic libtool

DESCRIPTION="tune your kernel and hardware settings for optimal performance"
HOMEPAGE="http://powertweak.sourceforge.net/"
SRC_URI="mirror://sourceforge/powertweak/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/libxml-1.8.10
	sys-devel/autoconf
	sys-devel/automake"
RDEPEND=">=sys-apps/pciutils-2.1.0
	gtk? ( =x11-libs/gtk+-1.2* )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S} ; patch -l -p1 < ${FILESDIR}/${P}-gentoo.diff

	for FILE in `find . -iname "Makefile*"`;do
		sed -i -e "s:\(^CFLAGS =.*\):\1 ${CFLAGS}:" \
			-e "s:\(^CPPFLAGS =.*\):\1 ${CPPFLAGS}:" \
			${FILE} || die "Hack failed"
	done
}

src_compile() {
	elibtoolize

	use gtk || myconf="--disable-gtktest"

	append-flags "-Wno-error"

	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	docinto Documentation
	dodoc Documentation/* Documentation/Hackers/*

	use gtk || rm ${D}/usr/bin/gpowertweak

	exeinto /etc/init.d ; newexe ${FILESDIR}/powertweakd.rc6 powertweakd
}

pkg_postinst() {
	einfo "This version adds powertweakd to be run at boot to apply changes to system"
}
