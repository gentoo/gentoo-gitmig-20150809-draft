# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.5.6-r1.ebuild,v 1.2 2006/08/14 13:11:56 liquidx Exp $

inherit kde-functions autotools eutils

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="kde nls"
LANGS="am ar bn gu hi ja kn ko ml ne pa ru ta te th vi zh"
for i in ${LANGS} ; do
	IUSE="${IUSE} linguas_${i}"
done

RDEPEND="|| ( x11-libs/libXt virtual/x11 )
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )
	!alpha? ( !sparc? ( kde? ( app-i18n/skim ) ) )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

RESTRICT="confcache"

pkg_setup() {
	einfo "Not all languages are going to be compiled."
	einfo "Please set LINGUAS to your preferred language(s)."
	einfo "Supported LINGUAS values are:"
	einfo "${LANGS}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fixconfigure.patch"
	epatch "${FILESDIR}/${PN}-qt335.patch"

	#AT_NO_RECURSIVE=yes eautoreconf
	AT_NO_RECURSIVE=yes AT_M4DIR=${S}/m4 eautoreconf
}

src_compile() {
	strip-linguas ${LANGS}
	local use_languages="additional ${LINGUAS}"
	einfo "Languages being compiled are: ${use_languages}"

	for m in Makefile.in Makefile.am ; do
		sed -e "/^SUBDIRS/s/.*/SUBDIRS = ${use_languages}/g" \
			tables/${m} > ${T}/${m} || die "sed ${m} failed"
		cp ${T}/${m} tables/${m} || die "mv ${m} failed"
	done

	econf \
		$(use_enable kde skim-support) \
		$(use_enable nls) \
		--disable-static \
		--disable-dependency-tracking \
		--without-arts || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog AUTHORS
}
