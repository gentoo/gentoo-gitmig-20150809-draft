# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-1.17.0.ebuild,v 1.1 2012/12/08 09:31:21 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1 vcs-snapshot

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.openembedded.org/bitbake.git"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="https://github.com/openembedded/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~x86"
fi

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND="
	|| (
		dev-lang/python:2.7[sqlite]
		dev-lang/python:2.6[sqlite]
		dev-lang/python:2.5[sqlite]
		>=dev-python/pysqlite-2.3.2
	)
	dev-python/ply
	dev-python/progressbar"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt )"

src_prepare() {
	if ! use doc ; then
		sed -i -e 's:doctype = "html":doctype = "none":' \
			-e 's:("share/doc/bitbake-%s/manual.*))::' setup.py || die
		echo "none:" >> doc/manual/Makefile || die
	else
	    sed -i -e "s:\(share/doc/bitbake-%s.* %\) __version__:\1 \"${PV}\":" setup.py || die
	fi
}
