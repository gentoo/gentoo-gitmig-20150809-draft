# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-help/gimp-help-0.11.ebuild,v 1.1 2007/01/18 17:35:15 masterdriverz Exp $

MY_P=${P/gimp-help/gimp-help-2}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU Image Manipulation Program help files"
HOMEPAGE="http://docs.gimp.org/"
SRC_URI="mirror://gimp/help/${MY_P}.tar.gz"

LICENSE="FDL-1.2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="imagemagick linguas_cs linguas_de linguas_en linguas_fr linguas_hr linguas_it linguas_nl linguas_sv linguas_zh_CN"
DEPEND="=app-text/docbook-xml-dtd-4.3*
		dev-libs/libxml2
		dev-libs/libxslt
		imagemagick? ( media-gfx/imagemagick )"
RDEPEND="!<media-gfx/gimp-2.2.12"

src_compile() {
	local ALL_LINGUAS=""

	use linguas_cs && ALL_LINGUAS="${ALL_LINGUAS} cs"
	use linguas_de && ALL_LINGUAS="${ALL_LINGUAS} de"
	use linguas_en && ALL_LINGUAS="${ALL_LINGUAS} en"
	use linguas_fr && ALL_LINGUAS="${ALL_LINGUAS} fr"
	use linguas_hr && ALL_LINGUAS="${ALL_LINGUAS} hr"
	use linguas_it && ALL_LINGUAS="${ALL_LINGUAS} it"
	use linguas_nl && ALL_LINGUAS="${ALL_LINGUAS} nl"
	use linguas_sv && ALL_LINGUAS="${ALL_LINGUAS} sv"
	use linguas_zh_CN && ALL_LINGUAS="${ALL_LINGUAS} zh_CN"

	ALL_LINGUAS=${ALL_LINGUAS} \
		econf \
		--without-gimp \
		$(use_enable imagemagick convert) \
		|| die "econf failed"

	# not parallel make safe (#137192)
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog HACKING NEWS README TERMINOLOGY TODO
}
