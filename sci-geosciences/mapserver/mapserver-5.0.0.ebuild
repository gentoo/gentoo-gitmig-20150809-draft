# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapserver/mapserver-5.0.0.ebuild,v 1.7 2008/05/17 10:25:04 bicatali Exp $

PHP_EXT_NAME="php_mapscript php_proj"
RUBY_OPTIONAL="yes"

inherit eutils autotools distutils depend.php depend.apache webapp ruby java-pkg-opt-2

DESCRIPTION="OpenSource development environment for constructing spatially enabled Internet-web applications."
HOMEPAGE="http://mapserver.gis.umn.edu/"
SRC_URI="http://download.osgeo.org/mapserver/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

#I must check for mygis use flag availability
#"mono"
IUSE="agg xml pdf proj geos tiff gdal xpm postgis flash php python perl ruby tcl threads unicode java doc"

# compilation fails with jdk > 1.4 on some native part probably
RDEPEND="media-libs/libpng
	media-libs/jpeg
	media-libs/freetype
	sys-libs/zlib
	>=media-libs/gd-2.0.12
	unicode? ( virtual/libiconv )
	agg? ( x11-libs/agg )
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj net-misc/curl )
	xml? ( dev-libs/libxml2 )
	gdal? ( >sci-libs/gdal-1.2.6 )
	postgis? ( dev-db/postgis )
	tiff? ( media-libs/tiff sci-libs/libgeotiff )
	xpm? ( x11-libs/libXpm )
	flash? ( media-libs/ming )
	pdf? ( media-libs/pdflib )
	php? ( dev-lang/php )
	ruby? ( dev-lang/ruby )
	perl? ( dev-perl/DBI )
	python? ( dev-lang/python )
	java? ( >=virtual/jdk-1.4 )
	tcl? ( dev-lang/tcl )"
DEPEND="${RDEPEND}
	php? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
	perl? ( dev-lang/swig )
	python? ( dev-lang/swig )
	java? ( dev-lang/swig )
	tcl? ( dev-lang/swig )"


WEBAPP_MANUAL_SLOT=yes

want_apache

cd_script() {
	einfo "$2 the mapserver $1-mapscript"
	cd "${S}"/mapscript/$1 || die "Unable to go into $1 mapscript dir"
}

pkg_setup(){
	webapp_pkg_setup
	java-pkg-opt-2_pkg_setup
	if use php; then
		# check how many versions of php was installed
		has_php
		np=0
		if has_version '=dev-lang/php-5*'; then
			np="$(expr ${np} + 1)"
		fi
		if has_version '=dev-lang/php-4*' ; then
			np="$(expr ${np} + 1)"
			myphp4=true
		fi
		toD="$(if [ ${np} -gt 1 ]; then echo s; fi)"
		einfo "Using ${np} PHP version${toD}"
	fi

	elog "Checking for gd compiled with truetype support..."
	if built_with_use media-libs/gd truetype; then
		elog "Found truetype support; continuing..."
	else
		ewarn "media-libs/gd must be compiled with truetype support,"
		ewarn "and you probably want jpeg and png support also."
		elog "Please re-emerge gd with the truetype USE flag."
		die "gd not merged with truetype USE flag"
	fi

	if use gdal && use tiff; then
		ewarn "The MapServer tiff support is not compatible"
		ewarn "with gdal tiff support."
		elog "Please disable tiff support for mapserver."
		die "mapserver has tiff USE flag enabled"
	fi

	if use java && ! use threads; then
		ewarn "The MapServer Java support needs threads."
		elog "Please enable thread support for mapserver."
		die "mapserver has threads USE flag disabled"
	fi

}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if (use tcl); then
		epatch "${FILESDIR}"/${PN}_tcl.patch
	fi

	if (use php); then
		if [ ${np} -eq 2 ]; then
			mkdir ./mapscript/php4
			cp -r ./mapscript/php3 ./mapscript/php5 ||\
				die "Unable to copy php mapscript directory"
			epatch "${FILESDIR}"/${PF}_php.patch
		fi
	fi
	if [ ! -z "${myphp4}" ]; then
		epatch "${FILESDIR}"/${PN}_php4.patch
	fi

}

src_compile() {
	local step
	step="Building"
	cd "${S}"

	AT_GNUCONF_UPDATE="no" eautoreconf

	local myconf
	myconf="--with-png --with-jpeg --with-zlib --with-freetype"
	if use apache2 ; then
		myconf="${myconf} --with-httpd=${APACHE_BIN}"
	fi

	if use geos; then
		myconf="${myconf} --with-geos=$(type -P geos-config)"
	fi

	local MYGPUSE="wfs wcs wfsclient"

	if (use gdal && use proj); then
		myconf="--with-ogr ${myconf}";
		for i in ${MYGPUSE}; do
			myconf="${myconf} --with-${i}"
		done
		if (use xml); then
			myconf="${myconf} --with-sos"
		fi
	fi

	if (use proj); then
		myconf="${myconf} --with-wmsclient"
	fi

	if (use php); then
		ewarn "You use ${np} version of php"
		if [ ${np} -eq 2 ] ; then
			for i in 4 5; do
				uses_php${i}
				myconf="${myconf} --with-php${i}=${PHPPREFIX}"
			done
		else
			myconf="${myconf} --with-php=${PHPPREFIX}/include/php"
		fi
	fi

	if (use perl || use python || use ruby || use tcl || use php) ; then
		myconf="${myconf} --with-mapscript";
	fi

	cd "${S}"
	econf $(use_with gdal)\
		$(use_with agg)\
		$(use_with perl)\
		$(use_with python)\
		$(use_with ruby)\
		$(use_with tcl)\
		$(use_with proj)\
		$(use_with postgis)\
		$(use_with tiff)\
		$(use_with pdf)\
		$(use_with flash ming)\
		$(use_with java)\
		$(use_with unicode iconv)\
		$(use_with threads)\
		${myconf}\
		|| die "econf failed"

	make || die "make failed"

	if (use php && use proj); then
		cd "${S}"/mapscript/php3/
		if [ ${np} -eq 2 ]; then
			cp *.so ../php4/ || die "Unable to copy php4 mapscript object files"
		fi
	fi

	if use perl; then
		cd_script perl ${step}
		perl Makefile.PL || die "Unable to build perl mapscript"
		emake || die "Unable to build perl mapscript"
	fi

	if use python; then
		cd_script python ${step}
		distutils_src_compile || die "Unable to build python mapscript"
	fi

	if use ruby; then
		cd_script ruby ${step}
		RUBY_ECONF="-I${D}"
		ruby_econf
		cp ../mapscript.i . || die "Unable to find mapscript.i"
		sed -e "s:ruby.h defines.h::g" -i ./Makefile
		ruby_emake
	fi

	if use tcl; then
		cd_script tcl ${step}
		sed "s:perlvars:mapscriptvars:" -i configure
		sed -e "s:tail -:tail -n :g" -e "s:head -:head -n :g" -i configure ||\
			die "Unable to modify the configure file"
		econf --with-tcl=/usr || die "Unable to configure tcl mapscript"
		touch tclmodule.i
		#sed -e "s:-DTCL_WIDE_INT_TYPE=long long:-DTCL_WIDE_INT_TYPE=long\\\ long:g" \
		#	-i Makefile || die "Unable to modify Makefile"
		emake || die "Unable to build tcl mapscript"
	fi

	if use java; then
		cd_script java ${step}
		emake interface || die "Unable to build java mapscript"
		emake all || die "Unable to build java mapscript"
	fi

}

src_test(){
	if use java ; then
		cd_script java test
		emake test || die "Test failed"
		# We need to fix the tests to make them pass
		sed -i -e "s:setTransparency:setOpacity:g" \
			"${S}"/mapscript/java/tests/threadtest/MapThread.java \
			|| die "fixing of tests failed"
		emake threadtests || die "Threadtests failed"
	fi
}

mapscript_install_examples() {
	einfo "$1-mapscript examples could be found in the following directory"
	einfo "/usr/share/doc/${PF}/mapscript/examples/$1"
	insinto /usr/share/doc/${PF}/mapscript/examples/$1/
	doins examples/* || die "Unable to install specified sample data"
}

src_install() {
	local step
	step="Installing"
	extra_dir="fonts tests tests/vera symbols"

	dodir /usr /usr/bin

	into /usr

	if use php; then
		if [ 2 -eq "${np}" ] ; then
			for i in 4 5; do
				cd_script php$i ${step}
				uses_php$i
				EXT_DIR="$(${PHPCONFIG} --extension-dir)"
				dodir ${EXT_DIR}
				cp *.so "${D}"/${EXT_DIR} || \
					die "Unable to setup php5 mapscript support"
			done
		else
			cd_script php3 ${step}
			EXT_DIR="$(${PHPCONFIG} --extension-dir)"
			dodir ${EXT_DIR}
			cp *.so "${D}"/${EXT_DIR} || \
				die "Unable to setup php4 mapscript support"
		fi
		mapscript_install_examples php
	fi

	if use ruby; then
			cd_script ruby ${step}
			ruby_einstall
			mapscript_install_examples ruby
	fi

	if use perl; then
			cd_script perl ${step}
			make DESTDIR="${D}" install || \
				die "Unable to setup perl mapscript support"
			mapscript_install_examples perl
	fi

	if use tcl; then
		cd_script tcl ${step}
		sed "s:\$(TCL_EXEC_PREFIX):\$(DESTDIR)\$(TCL_EXEC_PREFIX):g" -i Makefile
		make DESTDIR="${D}" install || \
			die "Unable to setup tcl mapscript support"
		mapscript_install_examples tcl
	fi

	if use python; then
			cd_script python ${step}
			distutils_src_install
			mapscript_install_examples python
	fi

	if (use java); then
		cd_script java ${step}
		java-pkg_dojar mapscript.jar
		java-pkg_doso libmapscript.so
		mapscript_install_examples java
	fi

	cd "${S}"
	into /usr

	if use pdf; then
		dobin shp2pdf || die "Unable to setup shp2pdf"
	fi

	dobin shp2img legend shptree shptreevis shp2img legend shptreetst scalebar\
		sortshp tile4ms msencrypt mapserver-config \
			|| die "Unable to setup mapserver tools"

	dodoc INSTALL README HISTORY.TXT || \
		die "Unable to setup documentation"

	for i in ${extra_dir}; do
		insinto /usr/share/doc/${PF}/$i
		doins $i/* || die "Unable to add extra_dir to document tree"
	done

	if use doc; then
		insinto /usr/share/doc/${PF}/rfc
		doins rfc/*

	fi

	webapp_src_preinst
	chmod +x "${S}"/mapserv || die "Unable to find mapserv"
	cp "${S}"/mapserv "${D}"/${MY_CGIBINDIR} || die "Unable to install mapserv"
	webapp_src_install
}
