# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.4.0.ebuild,v 1.6 2007/04/01 10:05:15 hansmi Exp $

WANT_AUTOMAKE=latest
WANT_AUTOCONF=latest

inherit elisp-common eutils autotools

MY_P=${P/_beta/-beta}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen"
HOMEPAGE="http://www.nongnu.org/ratpoison/"
LICENSE="GPL-2"

SRC_URI="http://savannah.nongnu.org/download/${PN}/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 hppa ppc sparc ~x86"
IUSE="emacs"

DEPEND="|| ( ( x11-libs/libXinerama x11-libs/libXtst ) virtual/x11 )
	virtual/perl-PodParser
	emacs? ( virtual/emacs )"

SITEFILE=50ratpoison-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}/contrib
	epatch ${FILESDIR}/ratpoison.el-gentoo.patch

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS} -I/usr/X11R6/include" || die
	if use emacs; then
		cd contrib && elisp-comp ratpoison.el
	fi
}

src_install() {
	einstall

	exeinto /etc/X11/Sessions
	newexe ${FILESDIR}/ratpoison.xsession ratpoison

	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc contrib/{genrpbindings,split.sh} \
		doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf $D/usr/share/{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
