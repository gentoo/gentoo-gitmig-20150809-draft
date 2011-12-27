# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/emul-linux-x86.eclass,v 1.10 2011/12/27 17:55:12 fauli Exp $

#
# Original Author: Mike Doty <kingtaco@gentoo.org>
# Adapted from emul-libs.eclass
# Purpose: Providing a template for the app-emulation/emul-linux-* packages
#

inherit versionator

if version_is_at_least 20110129; then
	IUSE="development"
else
	IUSE=""
fi

case "${EAPI:-0}" in
	0|1)
		EXPORT_FUNCTIONS src_unpack src_install
		;;
	2|3|4)
		EXPORT_FUNCTIONS src_unpack src_prepare src_install
		;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

if version_is_at_least 20110722; then
	SRC_URI="http://dev.gentoo.org/~pacho/emul/${P}.tar.xz"
else
	if version_is_at_least 20110129; then
		SRC_URI="http://dev.gentoo.org/~pacho/emul/${P}.tar.bz2"
	else
		SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2"
	fi
fi

DESCRIPTION="Provides precompiled 32bit libraries"
#HOMEPAGE="http://amd64.gentoo.org/emul/content.xml"
HOMEPAGE="http://dev.gentoo.org/~pacho/emul.html"

RESTRICT="strip"
S=${WORKDIR}

SLOT="0"

DEPEND=">=sys-apps/findutils-4.2.26"
RDEPEND=""

emul-linux-x86_src_unpack() {
	unpack ${A}
	cd "${S}"
	has ${EAPI:-0} 0 1 && emul-linux-x86_src_prepare
}

emul-linux-x86_src_prepare() {
	ALLOWED=${ALLOWED:-^${S}/etc/env.d}
	has development "${IUSE//+}" && use development && ALLOWED="${ALLOWED}|/usr/lib32/pkgconfig"
	find "${S}" ! -type d ! -name '*.so*' | egrep -v "${ALLOWED}" | xargs -d $'\n' rm -f || die 'failed to remove everything but *.so*'
}

emul-linux-x86_src_install() {
	has ${EAPI:-0} 0 1 2 && ! use prefix && ED="${D}"
	for dir in etc/env.d etc/revdep-rebuild ; do
		if [[ -d "${S}"/${dir} ]] ; then
			for f in "${S}"/${dir}/* ; do
				mv -f "$f"{,-emul}
			done
		fi
	done

	# remove void directories
	find "${S}" -depth -type d -print0 | xargs -0 rmdir 2&>/dev/null

	cp -pPR "${S}"/* "${ED}"/ || die "copying files failed!"
}
