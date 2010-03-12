# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/isbg/isbg-0.99.ebuild,v 1.1 2010/03/12 09:46:45 wired Exp $

EAPI=3

MY_P="${P/-/_}_20100303"
DESCRIPTION="IMAP Spam Begone: a script that makes it easy to scan an IMAP inbox for spam using SpamAssassin"
HOMEPAGE="http://redmine.ookook.fr/projects/isbg"
SRC_URI="http://github.com/downloads/ook/${PN}/${MY_P}.tgz"

# upstream says:
# You may use isbg under any OSI approved open source license
# such as those listed at http://opensource.org/licenses/alphabetical
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	|| ( dev-lang/python:2.6 dev-lang/python:2.5 dev-lang/python:2.4 )
	mail-filter/spamassassin
"

src_install() {
	dobin isbg.py || die "script installation failed"
	dodoc CHANGELOG CONTRIBUTORS README || die "doc installation failed"
}
