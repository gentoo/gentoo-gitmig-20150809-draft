# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mahogany/mahogany-0.65.ebuild,v 1.1 2005/01/10 02:40:13 ticho Exp $

inherit wxwidgets

DESCRIPTION="Highly customizable powerful mail client"
SRC_URI="mirror://sourceforge/mahogany/${P}.tar.bz2"
HOMEPAGE="http://mahogany.sourceforge.net"

KEYWORDS="~x86"
SLOT="0"
LICENSE="mahogany"
IUSE="python ssl static nls debug doc"

RDEPEND=">=x11-libs/wxGTK-2.4.2
	python? ( >=dev-lang/python-1.5*
			<dev-lang/python-2.2* )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	doc? ( dev-tex/latex2html )"


src_compile() {
	local myconf

	need-wxwidgets gtk || die "Emerge wxGTK with -no_wxgtk1 in USE"
	myconf="--with-wx-config=${WX_CONFIG_NAME}"

	if use python; then
		myconf="${myconf} --with-python="
		use static && myconf="${myconf}static" || myconf="${myconf}dynamic"
	else
		myconf="--with-python=none"
	fi
	use static && myconf="${myconf} --with-modules=static"
	use nls || myconf="${myconf} --disable-nls"
	use debug && myconf="${myconf} --enable-debug"

	econf ${myconf} || die
	emake || die
}

src_install() {
	addwrite /var/cache/fonts
	make DESTDIR=${D}/usr install_bin || die

	if use nls; then
		make DESTDIR=${D}/usr install_locale
	fi

	if use doc; then
		make DESTDIR=${D}/usr install_doc || die
	fi

	dodir /etc
	cp extra/install/M.conf ${D}/etc

	dodoc COPYING CREDITS CHANGES INSTALL README
	if use doc; then
		cd ${D}/usr/share/Mahogany/doc
		dodoc Pdf/*
		dohtml -r Manual HackersGuide
		rm -rf COPYING CREDITS CHANGES INSTALL README Pdf Manual HackersGuide
	fi
}
