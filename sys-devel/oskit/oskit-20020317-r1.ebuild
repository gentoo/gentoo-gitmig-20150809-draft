# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/oskit/oskit-20020317-r1.ebuild,v 1.1 2004/03/24 00:23:08 avenj Exp $

inherit flag-o-matic

PATCH_REV="20040319"

DESCRIPTION="Building blocks for a x86 operating system."
HOMEPAGE="http://www.cs.utah.edu/flux/oskit/"
SRC_URI="ftp://flux.cs.utah.edu/flux/oskit/${P}.tar.gz
		mirror://gentoo/oskit-${PATCH_REV}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
DEPEND="doc? ( app-text/tetex )"
IUSE="debug oskit-profiling oskit-noassert doc oskit-nobuild oskit-noconf"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/oskit-${PATCH_REV}.patch.bz2
}

src_compile() {
	local myconf
	if [ -n "$(use debug && use oskit-noassert)" ] ; then
		ewarn "Configuring for debugging without assertions!"
		echo -e '\a' 1>&2
		sleep 5
	fi
	#if [ -z $(use oskit-nobuild) ] && [ ! -z $(use oskit-noconf) ] ; then
	#	eerror "Building but not configuring"
	#	die
	#fi
	use debug && myconf="${myconf} --enable-debug"
	use oskit-profiling && myconf="${myconf} --enable-profiling"
	use oskit-noassert && myconf="${myconf} --disable-asserts"
	use doc && myconf="${myconf} --enable-doc"
	if [ -n "${OSKIT_MODULEFILE}" ] ; then
		if [ -f "${OSKIT_MODULEFILE}" ] ; then
			myconf="${myconf} --enable-modulefile=${OSKIT_MODULEFILE}"
		else
			ewarn "Modulefile ${OSKIT_MODULEFILE} does not exist or is not a file, not using!"
			echo -e '\a' 1>&2
			sleep 5
		fi
	fi
	if [ -n "$(use oskit-nobuild)" ] ; then
		if [ -n "$(use oskit-noconf)" ] ; then
			einfo "Configuring OSKit, but not building..."
			econf ${myconf} || die
		fi
	else
		einfo "Configuring OSKit..."
		econf ${myconf} || die
		einfo "Compiling OSKit..."
		make || die
	fi
}

src_install() {
	if [ -n "$(use oskit-nobuild)" ] ; then
		dodir /usr/src
		cd ${WORKDIR}
		einfo "Fixing permissions and ownership..."
		chown -R root:root * || die
	        chmod -R a+r-w+X,u+w * || die
		einfo "Installing OSKit sources..."
		mv ${S} ${D}/usr/src || die
		rm -f ${WORKDIR}/../.unpacked
	else
		einfo "Installing OSKit..."
		einstall || die
	fi
}
