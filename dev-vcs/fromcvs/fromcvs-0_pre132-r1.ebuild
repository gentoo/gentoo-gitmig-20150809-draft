# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fromcvs/fromcvs-0_pre132-r1.ebuild,v 1.1 2011/06/18 09:51:59 sochotnicky Exp $

EAPI=4

USE_RUBY="ruby18 ree18"

#mercurial after ruby!
inherit ruby-ng mercurial

MY_PV="${PV#0_pre}"

DESCRIPTION="fromcvs converts cvs to git, hg or sqlite database"
HOMEPAGE="http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs"
SRC_URI=""
EHG_REPO_URI="http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs"
EHG_REVISION="${MY_PV}"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+git mercurial sqlite"

RUBY_S="${P}"
# return S to default after ruby-ng has modified it
S="${WORKDIR}/${RUBY_S}"

RDEPEND="${RDEPEND}
	git? ( dev-vcs/git )
	mercurial? ( dev-vcs/mercurial )"

ruby_add_rdepend "dev-ruby/rcsparse
	>=dev-ruby/rbtree-0.3.0-r2
	sqlite? ( dev-ruby/sqlite3-ruby )"

src_prepare() {
	# prepare scripts that will go into bin
	for script in togit.rb tohg.rb todb.rb;do
		sed -i '1 i #!/usr/bin/ruby' ${script}
		mv ${script} ${script%.rb}
	done

	# this is a workaround because combination of ruby-ng and mercurial is
	# not working correctly for unpacking
	for rubyv in ${USE_RUBY} all;do
		mkdir "${WORKDIR}/${rubyv}"
		cp -prl "${S}" "${WORKDIR}/${rubyv}/${RUBY_S}"
	done
}

each_ruby_install() {
	insinto $(ruby_rbconfig_value 'sitedir')
	doins *.rb || die "Installation of rb files failed"

	use git && dobin togit
	use mercurial && dobin tohg
	use sqlite && dobin todb
}
