# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.99.5-r1.ebuild,v 1.10 2006/12/14 18:37:36 masterdriverz Exp $

inherit eutils

DESCRIPTION="Tune your kernel and hardware settings for optimal performance"
HOMEPAGE="http://powertweak.sourceforge.net/"
SRC_URI="mirror://sourceforge/powertweak/${P}.tar.bz2
	http://dev.gentoo.org/~spock/portage/distfiles/powertweak-0.99.5-cvs20040417.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 -sparc -alpha"
IUSE="gtk"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	>=dev-libs/libxml2-2.3.0
	sys-devel/autoconf
	sys-devel/automake"
RDEPEND=">=sys-apps/pciutils-2.1.0
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch powertweak-0.99.5-cvs20040417.patch
	cd "${S}"
	epatch "${FILESDIR}/${P}-exec-stack.patch"
}

src_compile() {
	econf `use_enable gtk gtktest` || die
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
