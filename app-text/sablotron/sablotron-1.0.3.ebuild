# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sablotron/sablotron-1.0.3.ebuild,v 1.4 2008/12/12 19:19:40 flameeyes Exp $

inherit base autotools

MY_PN="Sablot"
MY_P="${MY_PN}-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="An XSLT Parser in C++"
HOMEPAGE="http://www.gingerall.org/sablotron.html"
SRC_URI="http://download-1.gingerall.cz/download/sablot/${MY_P}.tar.gz"

# Sablotron can optionally be built under GPL, using MPL for now
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="perl"

RDEPEND=">=dev-libs/expat-1.95.6-r1"
DEPEND="${RDEPEND}
	>=dev-perl/XML-Parser-2.3"

PATCHES="${FILESDIR}/1.0.3-libsablot-expat.patch"

src_unpack() {
	base_src_unpack

	eautoreconf
	elibtoolize
}

src_compile() {
	# Don't use --without-html-dir, since that ends up installing files under
	# the /no directory
	local myconf="--with-html-dir=/usr/share/doc/${PF}/html"

	use perl && myconf="${myconf} --enable-perlconnect"

	econf ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"

	dodoc README README_JS RELEASE src/TODO
}
