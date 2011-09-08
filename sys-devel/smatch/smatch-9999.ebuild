# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/smatch/smatch-9999.ebuild,v 1.1 2011/09/08 22:10:32 vapier Exp $

EAPI="2"

inherit multilib toolchain-funcs
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://repo.or.cz/smatch.git"
	inherit git
fi

DESCRIPTION="static analysis tool for C"
HOMEPAGE="http://smatch.sourceforge.net/"

if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
fi

LICENSE="OSL-1.1"
SLOT="0"
IUSE=""

RDEPEND="dev-db/sqlite"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e '/^PREFIX=/s:=.*:=/usr:' \
		-e '/^CFLAGS =/{s:=:+=:;s:-O2 -finline-functions:${CPPFLAGS}:}' \
		Makefile || die
}

src_compile() {
	emake PREFIX=/usr V=1 CC="$(tc-getCC)" smatch || die
}

src_install() {
	# default install target installs a lot of sparse cruft
	dobin smatch || die
	insinto /usr/share/smatch/smatch_data
	doins smatch_data/* || die
	dodoc FAQ README
}
