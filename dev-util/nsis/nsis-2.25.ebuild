# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nsis/nsis-2.25.ebuild,v 1.1 2007/04/18 21:18:26 mrness Exp $

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

src_compile() {
	# Try next version without SKIPUTILS
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPPLUGINS=System SKIPUTILS="NSIS Menu" VERSION=${PV} DEBUG=no STRIP=no || die "scons failed"
}

src_install() {
	# Try next version without SKIPUTILS
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPPLUGINS=System SKIPUTILS="NSIS Menu" VERSION=${PV} DEBUG=no STRIP=no install || die "scons install failed"

	fperms -R go-w,a-x,a+X /usr/share/${PN}/ /usr/share/doc/${P}/ /etc/nsisconf.nsh

	# Always strip Windows binaries; no point in having Windows debug info
	local STRIP_FLAGS="--strip-unneeded"
	echo
	echo "strip: mingw32-strip ${STRIP_FLAGS}"

	cd "${D}"
	local FILE
	for FILE in $(find -iregex '.*\.\(dll\|exe\)$' | sed 's:^\./::') ; do
		echo "   ${FILE}"
		mingw32-strip ${STRIP_FLAGS} "${FILE}"
	done
}
