# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.4.6.ebuild,v 1.1 2005/02/27 02:41:58 usata Exp $

inherit eutils kde-functions

PRIME_P=prime-0.9.4-beta2
PRIME_SCM=${PRIME_P}_${P/_*/}_2.scm
MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://uim.freedesktop.org/releases/${MY_P}.tar.gz
	http://prime.sourceforge.jp/src/${PRIME_SCM}"

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
		!app-i18n/uim-kdehelper )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp ${DISTDIR}/${PRIME_SCM} scm/prime.scm || die
	# we execute gtk-query-immodules-2.0 in pkg_postinst()
	# to not violate sandbox.
	sed -i -e "/gtk-query-immodules-2.0/s/.*/	:\\\\/g" \
		Makefile.am || die
	use X || sed -i -e '/^SUBDIRS/s/xim//' Makefile.in || die
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
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc doc/{HELPER-CANDWIN,KEY,UIM-SH}
	use X && dodoc doc/XIM-SERVER
}

pkg_postinst() {
	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo (uim doesn't support skkserv)."
	einfo "To use uim-prime you should emerge app-i18n/prime"
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
