# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapserver/mapserver-5.4.2-r1.ebuild,v 1.5 2011/02/22 16:28:31 scarabeus Exp $

EAPI="2"

PHP_EXT_NAME="php_mapscript php_proj"
RUBY_OPTIONAL="yes"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="mapscript.py"

inherit eutils autotools confutils multilib distutils depend.php perl-module php-ext-source-r1 depend.apache webapp ruby java-pkg-opt-2

WEBAPP_MANUAL_SLOT=yes

DESCRIPTION="OpenSource development environment for constructing spatially enabled Internet-web applications."
HOMEPAGE="http://mapserver.org"
SRC_URI="http://download.osgeo.org/mapserver/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

# I must check for mygis use flag availability
IUSE="agg doc flash gdal geos java perl php postgis proj python ruby tcl threads tiff unicode xml xpm" # mono

# compilation fails with jdk > 1.4 on some native part probably
RDEPEND="
	media-libs/libpng
	virtual/jpeg
	media-libs/freetype
	>=media-libs/gd-2.0.12[truetype,jpeg,png]
	sys-libs/zlib
	agg? ( x11-libs/agg )
	flash? ( media-libs/ming )
	gdal? ( >sci-libs/gdal-1.2.6 )
	geos? ( sci-libs/geos )
	java? ( >=virtual/jdk-1.4 )
	perl? ( dev-perl/DBI )
	php? ( dev-lang/php )
	postgis? ( dev-db/postgis )
	proj? ( sci-libs/proj net-misc/curl )
	ruby? ( dev-lang/ruby )
	tcl? ( dev-lang/tcl )
	tiff? ( media-libs/tiff sci-libs/libgeotiff )
	unicode? ( virtual/libiconv )
	xml? ( dev-libs/libxml2 )
	xpm? ( x11-libs/libXpm )"

DEPEND="${RDEPEND}
	java? ( dev-lang/swig )
	perl? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
	python? ( dev-lang/swig )
	php? ( dev-lang/swig )
	tcl? ( dev-lang/swig )"
want_apache2

cd_script() {
	einfo "$2 the mapserver $1-mapscript"
	cd "${S}"/mapscript/$1 || die "Unable to go into $1 mapscript dir"
}

pkg_setup() {
	webapp_pkg_setup
	use java && java-pkg-opt-2_pkg_setup
	use perl && perl-module_pkg_setup
	use php && has_php

	confutils_use_conflict gdal tiff
	confutils_use_depend_all java threads
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-ldflags.patch

	if use tcl ; then
		epatch "${FILESDIR}"/${PN}_tcl.patch-r1
		sed -i -e "s:@libdir@:$(get_libdir):g" mapscript/tcl/Makefile.in \
			|| die "failed to fix libdir in Makefile.in"
	fi
	eautoreconf
}

src_configure() {
	local step="Configuration"

	local myconf="--with-png --with-jpeg --with-zlib --with-freetype"
	use apache2 && myconf="${myconf} --with-httpd=${APACHE_BIN}"
	use geos && myconf="${myconf} --with-geos=$(type -P geos-config)"

	local MYGPUSE="wfs wcs wfsclient"
	if use gdal && use proj ; then
		myconf="--with-ogr ${myconf}";
		for i in ${MYGPUSE}; do
			myconf="${myconf} --with-${i}"
		done
		use xml && myconf="${myconf} --with-sos"
	fi

	use proj && myconf="${myconf} --with-wmsclient"
	use php && myconf="${myconf} --with-php=${PHPPREFIX}/include/php"

	if use perl || use python || use ruby || use tcl || use php ; then
		myconf="${myconf} --with-mapscript"
	fi

	cd "${S}"
	econf \
		--without-pdf \
		$(use_with gdal) \
		$(use_with agg) \
		$(use_with perl) \
		$(use_with python) \
		$(use_with ruby) \
		$(use_with tcl) \
		$(use_with proj) \
		$(use_with postgis) \
		$(use_with tiff) \
		$(use_with flash ming) \
		$(use_with java) \
		$(use_with unicode iconv) \
		$(use_with threads) \
		${myconf}

	if use ruby; then
		cd_script ruby ${step}
		RUBY_ECONF="-I${D}"
		ruby_econf
		cp ../mapscript.i . || die "Unable to find mapscript.i"
		sed -e "s:ruby.h defines.h::g" -i ./Makefile
	fi

	if use tcl; then
		cd_script tcl ${step}
		sed "s:perlvars:mapscriptvars:" -i configure
		sed -e "s:tail -:tail -n :g" -e "s:head -:head -n :g" -i configure ||\
			die "Unable to modify the configure file"
		econf --with-tcl=/usr
		touch tclmodule.i
		# do not comment this sed out again because it will plain break build otherwise
		# thanks in advance
		sed -e "s:-DTCL_WIDE_INT_TYPE=long long:-DTCL_WIDE_INT_TYPE=long\\\ long:g" \
			-i Makefile || die "Unable to modify Makefile"
	fi
}

src_compile() {
	local step="Building"

	# bug #279627
	emake -j1 || die "make failed"

	if use perl; then
		cd_script perl ${step}
		perl-module_src_compile
	fi

	if use php && use proj; then
		cd_script php3 ${step}
		emake php_proj.so || die "unable to built php_proj.so"
	fi

	if use python; then
		cd_script python ${step}
		distutils_src_compile
	fi

	if use ruby; then
		cd_script ruby ${step}
		ruby_emake
	fi

	if use tcl; then
		cd_script tcl ${step}
		emake || die "Unable to build tcl mapscript"
	fi

	if use java; then
		cd_script java ${step}
		emake interface || die "Unable to build java mapscript"
		emake all || die "Unable to build java mapscript"
	fi

}

src_test(){
	local step="Testing"

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
	elog "$1-mapscript examples could be found in the following directory"
	elog "/usr/share/doc/${PF}/mapscript/examples/$1"
	insinto /usr/share/doc/${PF}/mapscript/examples/$1/
	doins examples/* || die "Unable to install specified sample data"
}

src_install() {
	local step="Installing"

	local extra_dir="fonts tests tests/vera symbols"

	dodir /usr /usr/bin

	into /usr

	if use php ; then
		cd_script php3 ${step}
		for i in *.so ; do
			cp ${i} "${WORKDIR}"/${i/.so}-default.so || die "failed to copy php extension"
			PHP_EXT_NAME="${i/.so}"
			php-ext-source-r1_src_install
		done

		mapscript_install_examples php
	fi

	if use ruby ; then
		cd_script ruby ${step}
			ruby_einstall
		mapscript_install_examples ruby
	fi

	if use perl ; then
		cd_script perl ${step}
		perl-module_src_install
		mapscript_install_examples perl
	fi

	if use tcl ; then
		cd_script tcl ${step}
		sed "s:\$(TCL_EXEC_PREFIX):\$(DESTDIR)\$(TCL_EXEC_PREFIX):g" -i Makefile
		emake -j1 DESTDIR="${D}" install || \
			die "Unable to setup tcl mapscript support"
		mapscript_install_examples tcl
	fi

	if use python ; then
		cd_script python ${step}
		distutils_src_install
		mapscript_install_examples python
	fi

	if use java ; then
		cd_script java ${step}
		java-pkg_dojar mapscript.jar
		java-pkg_doso libmapscript.so
		mapscript_install_examples java
	fi

	cd "${S}"
	into /usr

	dobin shp2img legend shptree shptreevis shp2img legend shptreetst scalebar \
		sortshp tile4ms msencrypt mapserver-config \
		|| die "Unable to setup mapserver tools"

	dodoc INSTALL README HISTORY.TXT || die "Unable to setup documentation"

	for i in ${extra_dir}; do
		insinto /usr/share/doc/${PF}/${i}
		doins ${i}/* || die "Unable to add extra_dir to document tree"
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

pkg_postinst() {
	webapp_pkg_postinst
	distutils_pkg_postinst
}

pkg_prerm() {
	webapp_pkg_prerm
}
