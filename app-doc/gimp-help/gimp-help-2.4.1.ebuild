# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/gimp-help/gimp-help-2.4.1.ebuild,v 1.4 2008/05/19 19:26:16 nixnut Exp $

inherit eutils autotools

DESCRIPTION="GNU Image Manipulation Program help files"
HOMEPAGE="http://docs.gimp.org/"
SRC_URI="mirror://gimp/help/${P}.tar.bz2"

LICENSE="FDL-1.2"
SLOT="2"
KEYWORDS="~alpha ~amd64 hppa ~ia64 -mips ppc ~ppc64 sparc ~x86 ~x86-fbsd"

IUSE=""

# Only *not* outdated translations (see, configure.ac) are listed.
# On update do not forgive to check quickreference/Makefile.am for
# QUICKREFERENCE_ALL_LINGUAS. LANGS should include that langs too.
LANGS="de en es fr it ko nl no pl ru sv"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

DEPEND="=app-text/docbook-xml-dtd-4.3*
		dev-libs/libxml2
		dev-libs/libxslt"
RDEPEND="=media-gfx/gimp-2.4*"

src_compile() {
	local ALL_LINGUAS=""

	for X in ${LANGS} ; do
		use linguas_${X} && ALL_LINGUAS="${ALL_LINGUAS} ${X}"
	done

	ALL_LINGUAS=${ALL_LINGUAS} \
		econf \
		--without-gimp \
		--disable-network \
		|| die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog HACKING NEWS README TERMINOLOGY
}
