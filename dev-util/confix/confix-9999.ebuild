# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/confix/confix-9999.ebuild,v 1.1 2009/11/03 17:08:59 mduft Exp $

EAPI=2

inherit distutils subversion

DESCRIPTION="Confix: A Build Tool on Top of GNU Automake"
HOMEPAGE="http://confix.sourceforge.net"

ESVN_REPO_URI="https://confix.svn.sourceforge.net/svnroot/confix/confix/trunk"
ESVN_PROJECT="${PN}"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool
	sys-devel/autoconf-archive
	dev-util/confix-wrapper
"

PYTHON_MODNAME="libconfix tests"

src_prepare() {
	# find jni-include dirs on hpux.
	epatch "${FILESDIR}"/2.1.0/jni-hpux.patch
	# hack to ignore duplicate files in rescan
# does not apply to trunk anymore
#	epatch "${FILESDIR}"/2.1.0/CALL_RESCAN_HACK.patch
	# add .exe extension to TESTS
	epatch "${FILESDIR}"/2.2.0/exeext.patch
	# use external autoconf archive
	epatch "${FILESDIR}"/2.2.0/ext-ac-archive.patch
	# enable SET_FILE_PROPERTIES(file, { 'PRIVATE_CINCLUDE', 1 })
# does not apply to trunk anymore
#	epatch "${FILESDIR}"/2.1.0/private-headers.patch
	# enable fast installation rules.
# does not apply to trunk anymore
#	epatch "${FILESDIR}"/2.1.0/fast-install.patch

	# need to store repos in exact versioned share/confix-PV/repo
	sed -i -e "s,'confix2','confix-${PV}'," \
		libconfix/plugins/automake/repo_automake.py \
		libconfix/core/machinery/repo.py \
	|| die "cannot adjust repo dir"

	# adjust version-printing to have same version as share/confix-PV/repo,
	# to ease revdep-rebuild-alike scripts for rebuilding confix-packages.
	sed -i -e "/^CONFIX_VERSION[ 	]*=/s,.*,CONFIX_VERSION = '${PV}'," \
		libconfix/core/utils/const.py \
	|| die "cannot adjust confix version"
}
