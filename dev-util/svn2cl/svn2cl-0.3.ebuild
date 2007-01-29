# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/svn2cl/svn2cl-0.3.ebuild,v 1.2 2007/01/29 00:30:42 trapni Exp $

inherit eutils

DESCRIPTION="Create a GNU-style ChangeLog from subversion's svn log --xml output."
HOMEPAGE="http://ch.tudelft.nl/~arthur/svn2cl/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE=""

RDEPEND="dev-libs/libxslt
	dev-util/subversion"

src_unpack() {
	unpack ${A}
	cd ${S}
	# the wrapper script looks for the xsl file in the
	# same directory as the script.
	epatch ${FILESDIR}/${PN}-no-same-dir-xsl.diff
}

src_install() {
	newbin svn2cl.sh svn2cl || die "failed to install wrapper script"
	insinto /usr/share/svn2cl
	doins svn2cl.xsl || die "failed to install xsl"
	dodoc README
}
