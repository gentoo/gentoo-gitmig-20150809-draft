# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/predict/predict-2.2.2-r2.ebuild,v 1.1 2004/10/25 09:20:08 phosphan Exp $

DESCRIPTION="Satellite tracking and orbital prediction."
HOMEPAGE="http://www.qsl.net/kd2bd/predict.html"
SRC_URI="http://www.amsat.org/amsat/ftp/software/Linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="xforms gtk nls"
KEYWORDS="~x86 ~ppc"

DEPEND="sys-libs/ncurses
	gtk? ( =x11-libs/gtk+-1.2* )
	xforms? ( x11-libs/xforms )"
RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	xforms? ( x11-libs/xforms )"

if [ -x /usr/bin/xearth ]; then
	EARTHTRACKOK="yes"
elif [ -x /usr/bin/xplanet ]; then
	EARTHTRACKOK="yes"
fi

src_compile() {
	# predict uses a ncurses based configure script
	# this is what it does if it was bash based ;)

	# set compiler string to a var so if compiler checks
	# can be added at a later date
	COMPILER="cc ${CFLAGS} -fomit-frame-pointer"

	# write predict.h
	echo "char *predictpath=\"/usr/share/predict/\";" > predict.h
	echo "char soundcard=1;" >> predict.h
	echo "char *version=\"${PV}\";" >> predict.h

	# compile predict
	einfo "compiling predict"
	${COMPILER} -L/lib -lm -lncurses -lpthread predict.c -o predict

	# write vocalizer.h
	cd vocalizer
	echo "char *path={\"/usr/share/predict/vocalizer/\"};" > vocalizer.h

	# compile vocalizer
	einfo "compiling vocalizer"
	${COMPILER} vocalizer.c -o vocalizer

	einfo "compiling clients"

	# earthtrack
	if test "${EARTHTRACKOK}" = "yes"; then
		einfo "compiling earthtrack"
		cd ${S}/clients/earthtrack
		${COMPILER} -lm earthtrack.c -o earthtrack
	fi

	# kep_reload
	einfo "compiling kep_reload"
	cd ${S}/clients/kep_reload
	${COMPILER} kep_reload.c -o kep_reload

	# map
	if use xforms; then
		einfo "compiling map"
		cd ${S}/clients/map
		TCOMP="${COMPILER} -I/usr/X11R6/include -L/usr/X11R6/lib -lforms -lX11 -lm map.c map_cb.c map_main.c -o map"
		${TCOMP}
	fi

	# gsat
	if use gtk; then
		# note there are plugins for gsat but they are missing header files and wont compile
		use nls || myconf="--disable-nls"
		einfo "compiling gsat"
		cd ${S}/clients/gsat-*
		./configure --prefix=/usr ${myconf}
		cd src
		sed -e "s:#define DEFAULTPLUGINSDIR .*:#define DEFAULTPLUGINSDIR \"/usr/lib/gsat/plugins/\":" -i globals.h
		sed -e 's:int errno;::' -i globals.h
		cd ..
		emake
	fi
}

src_install() {
	# install predict
	cd ${S}
	dobin predict ${FILESDIR}/predict-update
	dodoc CHANGES COPYING CREDITS HISTORY README
	dodoc default/predict.*
	dodoc docs/pdf/predict.pdf
	dodoc docs/postscript/predict.ps
	doman docs/man/predict.1

	#install vocalizer
	exeinto /usr/bin
	cd vocalizer
	doexe vocalizer
	dodir /usr/share/predict/vocalizer
	insinto /usr/share/predict/vocalizer
	dosym  /usr/bin/vocalizer /usr/share/predict/vocalizer/vocalizer
	doins *.wav

	mv README README.vocalizer
	dodoc README.vocalizer

	# install clients

	# earthtrack
	if test "${EARTHTRACKOK}" = "yes"; then
		cd ${S}/clients/earthtrack
		ln -s earthtrack earthtrack2
		dobin earthtrack earthtrack2
		mv README_FIRST README_FIRST.earthtrack
		mv README README.earthtrack
		dodoc README_FIRST.earthtrack README.earthtrack
	fi

	# kep_reload
	cd ${S}/clients/kep_reload
	dobin kep_reload
	mv INSTALL INSTALL.kep_reload
	mv README README.kep_reload
	dodoc INSTALL.kep_reload README.kep_reload

	# map
	if use xforms; then
		cd ${S}/clients/map
		dobin map
		for i in CHANGES README COPYING; do
			mv ${i} ${i}.map
			dodoc ${i}.map
		done
	fi

	# gsat
	if use gtk; then
		# the install seems broken so do manually...
		cd ${S}/clients/gsat-*
		dodir /usr/lib/gsat/plugins
		keepdir /usr/lib/gsat/plugins
		cd src
		dobin gsat
		cd ..
		for i in AUTHORS ABOUT-NLS COPYING ChangeLog INSTALL NEWS README Plugin_API; do
			mv ${i} ${i}.gsat
			dodoc ${i}.gsat
		done
	fi
}

pkg_postinst() {
	einfo "to use the clients the following line will"
	einfo "have to be inserted into /etc/services"
	einfo "predict    1210/udp"
	einfo "the port can be changed to anything"
	einfo "the name predict is what is needed to work"
	einfo "after that is set run 'predict -s'"
	einfo ""
	einfo "to get list of satellites run 'predict-update'"
	einfo "before running predict this script will also update"
	einfo "the list of satellites so they are up to date."
}
