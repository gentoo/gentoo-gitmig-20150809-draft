# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcsparse/rcsparse-0_pre45.ebuild,v 1.1 2011/06/15 22:01:26 sochotnicky Exp $

EAPI=2

USE_RUBY="ruby18 ree18"

#mercurial after ruby!
inherit ruby-ng mercurial

MY_PV="${PV#0_pre}"

DESCRIPTION="rcsparse ruby module"
HOMEPAGE="http://ww2.fs.ei.tum.de/~corecode/hg/rcsparse"
SRC_URI=""
EHG_REPO_URI="http://ww2.fs.ei.tum.de/~corecode/hg/rcsparse"
EHG_REVISION="${MY_PV}"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RUBY_S="${PN}-${PV}"

# this is a workaround because combination of ruby-ng and mercurial is
# not working correctly for unpacking
src_prepare() {
	for rubyv in ${USE_RUBY}; do
		mkdir "${WORKDIR}/$rubyv"
		cp -prl "${S}" "${WORKDIR}/$rubyv/${RUBY_S}"
	done
}

each_ruby_configure() {
		${RUBY} extconf.rb || die
}

each_ruby_compile() {
		emake || die
}

each_ruby_test() {
		${RUBY} test.rb || die
}

each_ruby_install() {
		emake DESTDIR="${D}" install || die
}
