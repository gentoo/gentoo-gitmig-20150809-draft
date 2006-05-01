# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-araneida/cl-araneida-0.90.1.ebuild,v 1.1 2006/05/01 20:28:49 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Araneida is small, highly-portable web server for Common Lisp"
HOMEPAGE="http://www.cliki.net/Araneida"
SRC_URI="http://common-lisp.net/project/araneida/release/araneida-version-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-split-sequence
	dev-lisp/cl-net-telent-date"
#	parenscript? ( dev-lisp/cl-parenscript )"
RDEPEND="${DEPEND}
	!standalone? ( || ( net-www/apache www-servers/pound ) )"

CLPACKAGE=araneida

S=${WORKDIR}/araneida-version-${PV}

src_unpack() {
	unpack ${A}
#	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	insinto $CLSOURCEROOT/araneida
	doins *.asd *.lisp NEWS
	for i in utility obsolete araneida-repl compat; do
		insinto $CLSOURCEROOT/araneida/$i
		doins $i/*
	done
	insinto $CLSOURCEROOT/araneida/doc
	doins doc/*.html doc/*.css doc/*.lisp doc/PLAN
	common-lisp-system-symlink
	dodoc doc/*.txt LICENCE* RELEASE_NOTES NEWS Notes README TODO
	dosym $CLSOURCEROOT/araneida/doc/ \
		/usr/share/doc/${PF}/html
	dodoc ${FILESDIR}/README.Gentoo
}
