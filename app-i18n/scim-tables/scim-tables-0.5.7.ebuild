# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.5.7.ebuild,v 1.6 2007/08/21 15:47:46 gustavoz Exp $

inherit kde-functions autotools eutils

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc sparc ~x86"
IUSE="kde nls"
LANGS="am ar bn gu hi ja kn ko ml ne pa ru ta te th vi zh"
for i in ${LANGS} ; do
	IUSE="${IUSE} linguas_${i}"
done

RDEPEND="x11-libs/libXt
	|| ( >=app-i18n/scim-1.1 >=app-i18n/scim-cvs-1.1 )
	!alpha? ( !sparc? ( kde? ( app-i18n/skim ) ) )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	elog "Not all languages are going to be compiled."
	elog "Please set LINGUAS to your preferred language(s)."
	elog "Supported LINGUAS values are:"
	elog "${LANGS}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.5.6-fixconfigure.patch"

	#AT_NO_RECURSIVE=yes eautoreconf
	AT_NO_RECURSIVE=yes AT_M4DIR=${S}/m4 eautoreconf
}

src_compile() {
	strip-linguas ${LANGS}
	local use_languages="additional ${LINGUAS}"
	elog "Languages being compiled are: ${use_languages}"

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
