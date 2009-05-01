# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.4.4-r1.ebuild,v 1.1 2009/05/01 11:23:51 jer Exp $

EAPI="2"

inherit elisp-common eutils autotools

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://www.nongnu.org/ratpoison/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug emacs +history xft"

DEPEND="x11-libs/libXinerama
	x11-libs/libXtst
	virtual/perl-PodParser
	emacs? ( virtual/emacs )
	history? ( sys-libs/readline )
	xft? ( x11-libs/libXft )"
RDEPEND="${DEPEND}"

SITEFILE=50ratpoison-gentoo.el

src_prepare() {
	cd "${S}/contrib"
	epatch "${FILESDIR}/ratpoison.el-gentoo.patch"

	cd "${S}"
	eautoreconf
}

src_configure() {
	local myconf
	use history || myconf="--disable-history"
	econf ${myconf} $(use_with xft) $(use_enable debug) || die "econf failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -I/usr/X11R6/include" || die "emake failed"
	if use emacs; then
		elisp-compile contrib/ratpoison.el || die "elisp-compile failed"
	fi
}

src_install() {
	einstall

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}/ratpoison.xsession" ratpoison

	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc contrib/{genrpbindings,split.sh} \
		doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf "${D}/usr/share/"{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
