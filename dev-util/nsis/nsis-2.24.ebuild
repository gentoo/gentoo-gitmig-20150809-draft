# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nsis/nsis-2.24.ebuild,v 1.1 2007/03/11 09:59:23 mrness Exp $

inherit eutils

DESCRIPTION="Nullsoft Scriptable Install System"
HOMEPAGE="http://nsis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/scons-0.96.93"

S="${WORKDIR}"/${P}-src

pkg_setup() {
	if ! has_version cross-mingw32/gcc; then
		eerror "Before you could emerge nsis, you need to install mingw32."
		eerror "Run the following command:"
		eerror "  emerge crossdev && crossdev mingw32"
		die "cross-mingw32/gcc is needed"
	fi
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-no-strict-aliasing.patch
}

src_compile() {
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPPLUGINS=System VERSION=${PV} STRIP=no || die "scons failed"
}

src_install() {
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPPLUGINS=System VERSION=${PV} STRIP=no install || die "scons install failed"

	fperms -R go-w,a-x,a+X /usr/share/${PN}/ /usr/share/doc/${P}/ /etc/nsisconf.nsh

	# Strip Windows binaries
	if ! hasq nostrip ${FEATURES} ; then
		local STRIP_FLAGS=${PORTAGE_STRIP_FLAGS:---strip-unneeded}
		echo
		echo "strip: mingw32-strip $STRIP_FLAGS"

		cd "${D}"
		local FILE
		for FILE in $(find -iregex '.*\.\(dll\|exe\)$' | sed 's:^\./::') ; do
			if [[ "${FILE##*\/}" = "NSIS.exe" ]]; then
				# This program is distributed binary with nothing strippable in it
				# Avoid "File in wrong format" error
				continue
			fi
			echo "   ${FILE}"
			mingw32-strip ${STRIP_FLAGS} "${FILE}"
		done
	fi
}
