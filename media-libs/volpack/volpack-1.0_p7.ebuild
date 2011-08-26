# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/volpack/volpack-1.0_p7.ebuild,v 1.2 2011/08/26 02:01:13 mattst88 Exp $

EAPI=2
inherit eutils

MYP=${PN}-${PV/_p/c}
DESCRIPTION="Volume rendering library"
HOMEPAGE="http://amide.sourceforge.net/packages.html"
SRC_URI="mirror://sourceforge/amide/${MYP}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="sys-devel/m4"
RDEPEND=""

S="${WORKDIR}/${MYP}"

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README ChangeLog
	insinto /usr/share/doc/${PF}/
	if use doc; then
		doins doc/*.pdf || die
		dohtml doc/*.html || die
	fi
	if use examples; then
		dodoc -r examples || die
	fi

}
