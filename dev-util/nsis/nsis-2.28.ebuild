# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nsis/nsis-2.28.ebuild,v 1.1 2007/06/19 20:08:20 mrness Exp $

DESCRIPTION="Nullsoft Scriptable Install System"
HOMEPAGE="http://nsis.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="config-log"

DEPEND=">=dev-util/scons-0.96.93"

S="${WORKDIR}"/${P}-src

pkg_setup() {
	local mingw32_variants="mingw32 i686-mingw32 i586-mingw32 i486-mingw32 i386-mingw32"
	local i
	for i in ${mingw32_variants} ; do
		type -p ${i}-gcc && return 0
	done

	eerror "Before you could emerge nsis, you need to install mingw32."
	eerror "Run the following command:"
	eerror "  emerge crossdev"
	eerror "then run _one_ of the following commands:"
	for i in ${mingw32_variants} ; do
		eerror "  crossdev ${i}"
	done
	die "mingw32 is needed"
}

get_additional_options() {
	local opts="VERSION=${PV} DEBUG=no STRIP=no"
	if use config-log ; then
		opts="${opts} NSIS_CONFIG_LOG=yes"
	fi
	if use amd64; then
		# Some part of the code cannot be compiled on 64-bit arches
		opts="${opts} APPEND_CCFLAGS=-m32 APPEND_LINKFLAGS=-m32"
	fi

	echo ${opts}
}

src_compile() {
	# Try next version without SKIPUTILS
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPUTILS="NSIS Menu" \
		$(get_additional_options) || die "scons failed"
}

src_install() {
	# Try next version without SKIPUTILS
	scons PREFIX=/usr PREFIX_CONF=/etc PREFIX_DOC="/usr/share/doc/${P}" PREFIX_DEST="${D}" \
		SKIPUTILS="NSIS Menu" \
		$(get_additional_options) install || die "scons install failed"

	fperms -R go-w,a-x,a+X /usr/share/${PN}/ /usr/share/doc/${P}/ /etc/nsisconf.nsh

	# Always strip Windows binaries; no point in having Windows debug info
	local mingw32_variants="mingw32 i686-mingw32 i586-mingw32 i486-mingw32 i386-mingw32"
	local STRIP_PROG
	local STRIP_FLAGS="--strip-unneeded"
	for i in ${mingw32_variants} ; do
		if type -p ${i}-strip ; then
			STRIP_PROG=${i}-strip
			break;
		fi
	done

	echo
	echo "strip: ${STRIP_PROG} ${STRIP_FLAGS}"

	cd "${D}"
	local FILE
	for FILE in $(find -iregex '.*\.\(dll\|exe\)$' | sed 's:^\./::') ; do
		echo "   ${FILE}"
		${STRIP_PROG} ${STRIP_FLAGS} "${FILE}"
	done
}
