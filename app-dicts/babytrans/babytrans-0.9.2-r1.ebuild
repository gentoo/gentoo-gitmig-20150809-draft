# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans/babytrans-0.9.2-r1.ebuild,v 1.1 2004/09/10 21:00:45 angusyoung Exp $

IUSE="gnome"

S=${WORKDIR}/${P}
DESCRIPTION="BabyTrans is a Linux clone of the popular Babylon Translator for Windows."
SRC_URI="http://fjolliton.free.fr/babytrans/test/${P}.tar.gz"
HOMEPAGE="http://fjolliton.free.fr/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 "

RDEPEND="=x11-libs/gtk+-1.2*
	>=app-dicts/babytrans-en-0.1
	>=app-dicts/babytrans-en2pt-0.1"

DEPEND="${RDEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${PF}.diff
	cd ${S}
}

src_compile() {

	local myopts

	use gnome \
		myopts="${myopts} --enable-gnome" \
		|| myopts="${myopts} --disable-gnome"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		${myopts} || die

	make || die
}

src_install() {
#Some stuff to create a gnome menu entry.	
	use gnome && ( \
		insinto /usr/share/gnome/apps/Utilities
		doins ${FILESDIR}/babytrans.desktop
	)
	insinto /usr/bin
	einstall || die
	insinto /usr/share/babytrans
	doins ${FILESDIR}/dictionary
	dodoc AUTHORS COPYING README
}
