# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-tables/scim-tables-0.5.8-r1.ebuild,v 1.1 2008/09/24 12:47:57 matsuu Exp $

inherit kde-functions eutils base autotools

DESCRIPTION="Smart Common Input Method (SCIM) Generic Table Input Method Server"
HOMEPAGE="http://www.scim-im.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="kde nls"
LANGS="am ar bn gu hi ja kn ko ml ne pa ru ta te th uk vi zh"
for i in ${LANGS} ; do
	IUSE="${IUSE} linguas_${i}"
done

RDEPEND="x11-libs/libXt
	>=app-i18n/scim-1.4.0
	kde? ( >=app-i18n/skim-1.2.0 )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}"/${P}+gcc-4.3.patch
)

pkg_setup() {
	if ! built_with_use '>=app-i18n/scim-1.4.0' gtk ; then
		eerror ">=app-i18n/scim-1.4.0 with gtk USE flag is required by ${PF}."
#		die "Please reemerge >=app-i18n/scim-1.4.0 with USE=\"gtk\"."
	fi

	elog "Not all languages are going to be compiled."
	elog "Please set LINGUAS to your preferred language(s)."
	elog "Supported LINGUAS values are:"
	elog "${LANGS}"
}

src_unpack() {
	base_src_unpack

	strip-linguas ${LANGS}
	local use_languages="additional ${LINGUAS}"
	elog "Languages being compiled are: ${use_languages}"

	cd "${S}"
	sed -i -e "/^SUBDIRS/s/.*/SUBDIRS = ${use_languages}/g" \
			tables/Makefile.am || die "sed ${m} failed"

	eautoreconf
}

src_compile() {
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
