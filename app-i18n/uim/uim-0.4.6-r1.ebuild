# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.4.6-r1.ebuild,v 1.1 2005/03/30 05:16:55 usata Exp $

inherit eutils kde-functions

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://uim.freedesktop.org/releases/${MY_P}.tar.gz
	http://lists.sourceforge.jp/mailman/archives/anthy-dev/attachments/20050313/47aab99c/skk-dic-serv.diff2.bin
	http://prime.sourceforge.jp/src/prime-1.0.0.1.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk qt immqt immqt-bc nls X m17n-lib canna"

RDEPEND="X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-2 )
	m17n-lib? ( dev-libs/m17n-lib )
	!app-i18n/uim-svn
	!app-i18n/uim-fep
	canna? ( app-i18n/canna )
	immqt? ( >=x11-libs/qt-3.3.3-r1 )
	immqt-bc? ( >=x11-libs/qt-3.3.3-r1 )
	qt? ( >=x11-libs/qt-3.3.3-r1
		!app-i18n/uim-kdehelper )
	!<app-i18n/prime-0.9.4"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cp "${DISTDIR}"/skk-dic-serv.diff2.bin "${WORKDIR}"/skk-dic-serv.diff2.gz

	cd "${S}"
	# we execute gtk-query-immodules-2.0 in pkg_postinst()
	# to not violate sandbox.
	sed -i -e "/gtk-query-immodules-2.0/s/.*/	:\\\\/g" \
		Makefile.am || die
	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
	cd uim; epatch "${WORKDIR}"/skk-dic-serv.diff2.gz
}

src_compile() {
	local myconf
	if use immqt || use immqt-bc ; then
		myconf="${myconf} --enable-qt-immodule"
		export CPPFLAGS="${CPPFLAGS} -I${S}/qt"
	fi
	use qt && set-qtdir 3

	econf \
		$(use_enable nls) \
		$(use_with X x) \
		$(use_with gtk gtk2) \
		$(use_with m17n-lib m17nlib) \
		$(use_with canna) \
		$(use_with qt) \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"

	cd ${WORKDIR}/prime-1.0.0.1
	econf || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	cd ${WORKDIR}/prime-1.0.0.1
	make DESTDIR="${D}" install-uim || die "make install-uim failed"
	cd -

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/{HELPER-CANDWIN,KEY,UIM-SH}
	use X && dodoc doc/XIM-SERVER
}

pkg_postinst() {
	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo

	ewarn
	ewarn "New input method switcher has been introduced. You need to set"
	ewarn
	ewarn "% GTK_IM_MODULE=uim ; export GTK_IM_MODULE"
	ewarn "% XMODIFIERS=@im=uim ; export XMODIFIERS"
	ewarn
	ewarn "If you would like to use uim-anthy as default input method, put"
	ewarn "(define default-im-name 'anthy)"
	ewarn "to your ~/.uim."
	ewarn
	ewarn "All input methods can be found by running uim-im-switcher-gtk"
	ewarn "or uim-im-switcher-qt."
	ewarn

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

pkg_postrm() {
	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}
