# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/bitpim/bitpim-0.8.12.ebuild,v 1.1 2006/04/22 12:52:26 mrness Exp $

inherit distutils

DESCRIPTION="This program allows you to view and manipulate data on LG VX4400/VX6000 and many Sanyo Sprint mobile phones"
HOMEPAGE="http://www.bitpim.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt usb evo"

DEPEND=">=dev-python/wxpython-2.6.3.2
	>=dev-python/apsw-3
	>=dev-python/python-dsv-1.4.0
	>=dev-python/pyserial-2.0
	crypt? ( >=dev-python/paramiko-1.5.4 )
	usb? ( >=dev-lang/swig-1.3.21 >=dev-libs/libusb-0.1.10a )"
RDEPEND="${DEPEND}
	media-video/ffmpeg
	media-libs/netpbm"

#pkg_setup() { maketarball; } #Uncomment this line when you want to make the tarball
maketarball() { #For building the tarball. To be used only by ebuild maintainers
	local x
	#Fetch the source (only those directories that are needed)
	cd "${DISTDIR}" && mkdir ${P} || return 1
	for x in resources src ; do
		svn export https://svn.sourceforge.net/svnroot/${PN}/releases/${PV}/${x} ${P}/${x} || return 1
	done

	#Remove unneeded stuff
	rm resources/*.chm

	#Make the tarball
	tar -cjf ${P}.tar.bz2 ${P}
	rm -r ${P}
}

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
	sed -i "s/python2.3/${python}/" "${S}/src/native/usb/build.sh"
}

src_compile() {
	# USB stuff
	if use usb; then
		cd "${S}/src/native/usb" || die "compilation of native/usb failed"
		sh ./build.sh
	fi

	# strings
	cd "${S}/src/native/strings"
	${python} setup.py build || die "compilation of native/strings failed"

	# bmp2avi
	cd "${S}/src/native/av/bmp2avi"
	PLATFORM=linux make || die "compilation of native/bmp2avi failed"
}

src_install() {
	cd "${S}"

	# Install files into right place
	#
	# BitPim is a self-contained app, so jamming it into 
	# Python's site-packages might not be worthwhile.  We'll
	# Put it in its own home, and add the PYTHONPATH in the 
	# wrapper executables below.
	distutils_python_version
	local RLOC=/usr/lib/${P}

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
	${python} setup.py install --root="${D}" --no-compile "$@" || die "install of native/strings failed"
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
	echo "export PYTHONPATH='$RLOC:$PYTHONPATH'" >> "${T}/bitpim"
	echo "exec python ${RLOC}/bp.py bitpim" >> "${T}/bitpim"
	dobin "${T}/bitpim"
	if use crypt; then
		echo '#!/bin/sh' > "${T}/bitfling"
		echo "export PYTHONPATH='$RLOC:$PYTHONPATH'" >> "${T}/bitfling"
		echo "exec python ${RLOC}/bp.py bitfling" >> "${T}/bitfling"
		dobin "${T}/bitfling"
	fi

	# Desktop file
	insinto /usr/share/applications
	cat <<EOF > "${T}/bitpim.desktop"
[Desktop Entry]
Name=BitPim
Comment=CDMA Mobile Phone Tool
Encoding=UTF-8
Exec=/usr/bin/bitpim
Icon=${RLOC}/resources/bitpim.ico
Terminal=0
Type=Application
Categories=Application;Calendar;ContactManagement;Utility;
EOF
	doins "${T}/bitpim.desktop"
}

pkg_postinst() {
	# Optimize in installed directory
	python_mod_optimize "${ROOT}/usr/lib/${P}"

	# Helpful message re. support
	einfo "For support information please visit http://bitpim.org/"
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}/usr/lib/${P}"
}
