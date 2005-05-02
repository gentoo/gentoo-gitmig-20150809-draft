# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/wxlib.eclass,v 1.3 2005/05/02 17:40:39 pythonhead Exp $

# Author Diego Pettenò <flameeyes@gentoo.org>
# Maintained by wxwidgets herd

# This eclass is used by wxlib-based packages (wxGTK, wxMotif, wxBase, wxMac) to share code between
# them.

inherit flag-o-matic eutils gnuconfig multilib toolchain-funcs

ECLASS="wxlib"
INHERITED="${INHERITED} ${ECLASS}"

IUSE="doc debug unicode dmalloc zlib"

LICENSE="wxWinLL-3"

# Note 1: Gettext is not runtime dependency even if nls? because wxWidgets
#         has its own implementation of it
# Note 2: PCX support is enabled if the correct libraries are detected.
#         There is no USE flag for this.
RDEPEND="!hppa? ( !alpha? ( !ppc64? ( !amd64? ( !arm? ( !mips? ( dmalloc? ( dev-libs/dmalloc ) ) ) ) ) ) )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	sys-apps/sed"

HOMEPAGE="http://www.wxwindows.org"
SRC_URI="mirror://sourceforge/wxwindows/wxWidgets-${PV}.tar.bz2
	doc? ( mirror://sourceforge/wxwindows/wxWidgets-${PV}-HTML.tar.gz )"
S=${WORKDIR}/wxWidgets-${PV}

# Verify wxWidget-2.6 tarball still has this hardcoded: pythonhead aprl 24 2005
# Removes -O2 optimization from configure
wxlib_src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s/-O2//g" configure || die "sed configure failed"
	gnuconfig_update
}

# Configure a build.
# It takes three parameters;
# $1: prefix for the build directory (used for wxGTK which has two
#     builds needed.
# $2: "unicode" if it must be build with else ""
# $3: all the extra parameters to pass to configure script
configure_build() {
	export LANG='C'
	
	mkdir ${S}/$1_build
	cd ${S}/$1_build
	# odbc works with ansi only:
	subconfigure $3 $(use_with odbc) || die "odbc does not work with unicode"
	emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake failed"
	#wxbase has no contrib:
	if [[ -e contrib/src ]]; then
		cd contrib/src
		emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake contrib failed"
	fi

	if [[ "$2" == "unicode" ]] && use unicode; then
		mkdir ${S}/$1_build_unicode
		cd ${S}/$1_build_unicode
		subconfigure $3 --enable-unicode
		emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "Unicode emake failed"
		if [[ -e contrib/src ]]; then
			cd contrib/src
			emake -j1 CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "Unicode emake contrib failed"
		fi
	fi
}

# This is a commodity function which calls configure script
# with the default parameters plus extra parameters. It's used
# as building the unicode version required redoing it.
# It takes all the params and pass them to the script
subconfigure() {
	debug_conf=""
	if use debug; then
		debug_conf="--enable-debug --enable-debug_gdb"	
		debug_conf="${debug_conf} `use_with dmalloc`"
	fi
	${S}/configure --enable-monolithic \
		--host=${CHOST} \
		--libdir=/usr/$(get_libdir) \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		`use_with zlib` \
		${debug_conf} \
		$* || die "./configure failed"
}

# Installs a build
# It takes only a parameter: the prefix for the build directory
# see configure_build function
install_build() {
	cd ${S}/$1_build
	einstall libdir="${D}/usr/$(get_libdir)" || die "Install failed"
	cd contrib/src
	einstall libdir="${D}/usr/$(get_libdir)" || die "Install contrib failed"
	if [[ -e ${S}/$1_build_unicode ]]; then
		cd ${S}/$1_build_unicode
		einstall libdir="${D}/usr/$(get_libdir)" || die "Unicode install failed"
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "Unicode install contrib failed"
	fi
}

# To be called at the end of src_install to perform common cleanup tasks
wxlib_src_install() {

	# In 2.6 all wx-config*'s go in/usr/lib/wx/config not
	# /usr/bin where 2.4 keeps theirs.
	# Only install wx-config if 2.4 is not installed:
	if [ -e "/usr/bin/wx-config" ]; then
		if [ "$(/usr/bin/wx-config --release)" = "2.4" ]; then
			rm ${D}/usr/bin/wx-config
		fi
	fi

	# Remove wxrc because SLOT'd versions will overwrite each other.
	# There will be a /usr/bin/wxrc-2.6 installed:
	rm ${D}/usr/bin/wxrc


	if use doc; then
		dohtml ${S}/contrib/docs/html/ogl/*
		dohtml ${S}/docs/html/*
		dodir /usr/share/doc/${PF}/demos
		cp -R ${S}/demos/* ${D}/usr/share/doc/${PF}/demos/
		dodoc ${S}/*.txt
	fi

}


EXPORT_FUNCTIONS src_unpack src_install
