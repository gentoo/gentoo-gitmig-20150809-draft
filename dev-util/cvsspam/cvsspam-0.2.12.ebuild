# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsspam/cvsspam-0.2.12.ebuild,v 1.4 2010/03/03 17:55:50 hwoarang Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Utility to send colored HTML CVS-mails"
SRC_URI="http://www.badgers-in-foil.co.uk/projects/cvsspam/releases/${P}.tar.gz"
HOMEPAGE="http://www.badgers-in-foil.co.uk/projects/cvsspam/"

LICENSE="GPL-2"
DEPEND=""
RDEPEND="dev-lang/ruby
	svn? ( dev-util/subversion )"
KEYWORDS="~amd64 ~x86 ~ppc"

SLOT="0"
IUSE="svn"

src_prepare() {
	use svn && epatch "${FILESDIR}/${P}-svn.patch"
}

src_install() {
	dobin collect_diffs.rb || die
	dobin cvsspam.rb || die
	dobin record_lastdir.rb || die
	insinto /etc/cvsspam || die
	doins cvsspam.conf || die

	dohtml cvsspam-doc.html
	dodoc CREDITS TODO cvsspam-doc.pdf
}
