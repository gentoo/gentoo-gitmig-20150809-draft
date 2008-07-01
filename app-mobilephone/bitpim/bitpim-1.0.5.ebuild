# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/bitpim/bitpim-1.0.5.ebuild,v 1.5 2008/07/01 18:56:50 mrness Exp $

inherit distutils fdo-mime multilib

DESCRIPTION="Program to view and manipulate data on LG VX4400/VX6000 and many Sanyo Sprint mobile phones"
HOMEPAGE="http://www.bitpim.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# this needs fixing
#KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="crypt evo usb"

COMMON_DEPEND="=dev-python/wxpython-2.8.7.1*
	>=dev-python/python-dsv-1.4.0
	>=dev-python/pyserial-2.2
	>=dev-python/apsw-3.3.13.1
	crypt? ( >=dev-python/paramiko-1.7.1
		>=dev-python/pycrypto-2.0.1 )
	usb? ( >=dev-libs/libusb-0.1.10a )"
DEPEND="${COMMON_DEPEND}
	usb? ( >=dev-lang/swig-1.3.21 )"
RDEPEND="${COMMON_DEPEND}
	media-video/ffmpeg
	media-libs/netpbm
	>=dev-lang/python-2.5"

#For Gentoo devs only: uncomment this line when you want to make the tarball
#then COMMENT IT BACK!
#pkg_setup() { maketarball; }
maketarball() { #For building the tarball. To be used only by ebuild maintainers
	local x svnrev
	svnrev=$(svn log -q --limit 1 https://${PN}.svn.sourceforge.net/svnroot/${PN}/releases/${PV} | sed -r '/^[^r]/d;s/^r([0-9]+) .*$/\1/')
	[ $? = 0 ] || return 1

	#Fetch the source (only those directories that are needed)
	cd "${DISTDIR}" && mkdir -p ${P} || return 1
	for x in resources packaging src ; do
		svn export https://${PN}.svn.sourceforge.net/svnroot/${PN}/releases/${PV}/${x} ${P}/${x} || return 1
	done

	#Remove unneeded stuff
	rm ${P}/resources/*.chm ${P}/src/package.py

	#Freeze version and set vendor name to Gentoo
	sed -i -e 's/\(^__FROZEN__="[$]Id: \).*\( $"\)/\1'${svnrev}'\2/' \
		-e 's/^vendor=".*"/vendor="Gentoo"/' \
		${P}/src/version.py || return 1

	#Make the tarball
	tar -cjf ${P}.tar.bz2 ${P}
	rm -r ${P}
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-ffmpeg_quality.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	sed -i "s/python2.3/${python}/" "${S}/src/native/usb/build.sh"
}

src_compile() {
	# USB stuff
	if use usb; then
	    cd "${S}/src/native/usb"
	    sh ./build.sh || die "compilation of native/usb failed"
	fi

	# strings
	cd "${S}/src/native/strings"
	${python} setup.py build || die "compilation of native/strings failed"

	# bmp2avi
	cd "${S}/src/native/av/bmp2avi"
	PLATFORM=linux make || die "compilation of native/bmp2avi failed"
}

src_install() {

	# Install files into right place
	#
	# BitPim is a self-contained app, so jamming it into
	# Python's site-packages might not be worthwhile.  We'll
	# Put it in its own home, and add the PYTHONPATH in the
	# wrapper executables below.
	distutils_python_version
	local RLOC=/usr/$(get_libdir)/${P}

	# Main Python source
	insinto ${RLOC}
	doins src/*.py

	# Phone specifics
	insinto ${RLOC}/phones
	doins src/phones/*.py

	# Native products
	insinto ${RLOC}/native
	doins src/native/*.py
	insinto ${RLOC}/native/qtopiadesktop
	doins src/native/qtopiadesktop/*.py
	insinto ${RLOC}/native/outlook
	doins src/native/outlook/*.py
	insinto ${RLOC}/native/egroupware
	doins src/native/egroupware/*.py
	if use evo ; then
		insinto ${RLOC}/native/evolution
		doins src/native/evolution/*.py
	fi

	# strings
	cd "${S}/src/native/strings"
	${python} setup.py install --root="${D}" --no-compile "$@" \
	    || die "install of native/strings failed"

	cd "${S}"
	insinto $RLOC/native/strings
	doins src/native/strings/__init__.py src/native/strings/jarowpy.py

	# usb
	if use usb; then
		insinto ${RLOC}/native/usb
		doins src/native/usb/*.py
		doins src/native/usb/*.so
	fi

	# Helpers and resources
	dobin src/native/av/bmp2avi/bmp2avi
	insinto ${RLOC}/resources
	doins resources/*

	# Bitfling
	if use crypt; then
		FLINGDIR="${RLOC}/bitfling"
		insinto $FLINGDIR
		cd "${S}/src/bitfling"
		doins *.py
		cd "${S}"
	fi

	# Creating scripts
	echo '#!/bin/sh' > "${T}/bitpim"
	echo "exec ${python} ${RLOC}/bp.py \"\$@\"" >> "${T}/bitpim"
	dobin "${T}/bitpim"
	if use crypt; then
		echo '#!/bin/sh' > "${T}/bitfling"
		echo "exec ${python} ${RLOC}/bp.py \"\$@\" bitfling" >> "${T}/bitfling"
		dobin "${T}/bitfling"
	fi

	# Desktop file
	insinto /usr/share/applications
	sed -i -e "s|%%INSTALLBINDIR%%|/usr/bin|" -e "s|%%INSTALLLIBDIR%%|${RLOC}|" \
		packaging/bitpim.desktop
	doins packaging/bitpim.desktop
}

pkg_postinst() {
	# Optimize in installed directory
	python_mod_optimize /usr/$(get_libdir)/${P}
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${P}
	fdo-mime_desktop_database_update
}
