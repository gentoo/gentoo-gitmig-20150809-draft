# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-syncml/libopensync-plugin-syncml-9999.ebuild,v 1.1 2007/11/26 20:25:13 peper Exp $

inherit eutils cmake-utils subversion

DESCRIPTION="OpenSync SyncML Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/plugins/syncml"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="http obex"

DEPEND="=app-pda/libopensync-${PV}*
	>=app-pda/libsyncml-0.4.3"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! use obex && ! use http; then
		eerror "${CATEGORY}/${P} without support for obex nor http is unusable."
		eerror "Please enable \"obex\" or/and \"http\" USE flags."
		die "Please enable \"obex\" or/and \"http\" USE flags."
	fi

	if use obex && ! built_with_use app-pda/libsyncml obex; then
		eerror "You are trying to build ${CATEGORY}/${P} with the \"obex\""
		eerror "USE flags, but app-pda/libsyncml was built without"
		eerror "the \"obex\" USE flag."
		eerror "Please rebuild app-pda/libsyncml with \"obex\" USE flag."
		die "Please rebuild app-pda/libsyncml with \"obex\" USE flag."
	fi

	if use http && ! built_with_use app-pda/libsyncml http; then
		eerror "You are trying to build ${CATEGORY}/${P} with the \"http\""
		eerror "USE flags, but app-pda/libsyncml was built without"
		eerror "the \"http\" USE flag."
		eerror "Please rebuild app-pda/libsyncml with \"http\" USE flag."
		die "Please rebuild app-pda/libsyncml with \"http\" USE flag."
	fi
}

src_compile() {
	local mycmakeargs="
		$(cmake-utils_use_enable http HTTP)
		$(cmake-utils_use_enable obex OBEX)"

	cmake-utils_src_compile
}
