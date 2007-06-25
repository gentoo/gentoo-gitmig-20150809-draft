# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rhide/rhide-1.5.20050823.ebuild,v 1.7 2007/06/25 10:54:44 peper Exp $

inherit eutils multilib toolchain-funcs

SNAPSHOT="20050823"
TVISIONVER="2.10.20050824"
SETEDITVER="0.5.5.20050828"
# RHIDE is _very_ picky about the GDB used, so dont put GDB in DEPEND
GDBVER="6.1.1"

# Used when you do not want to link TVision against X11, but do
# want to use RHIDE inside of X ...
ETERM_HACK="no"

DESCRIPTION="Console IDE for various languages"
HOMEPAGE="http://www.rhide.com/"
if [ -z "${SNAPSHOT}" ]
then
	SRC_URI="http://rhide.sourceforge.net/snapshots/${P}.tar.gz
		mirror://sourceforge/${PN}/${P}.tar.gz"
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~azarah/rhide/${P}.tar.bz2"
	#http://rhide.sourceforge.net/snapshots/${P/_}-${SNAPSHOT}.tar.gz
fi
SRC_URI="${SRC_URI}
	mirror://gentoo/tvision-${TVISIONVER}.tar.bz2
	http://dev.gentoo.org/~azarah/rhide/tvision-${TVISIONVER}.tar.bz2
	mirror://gentoo/setedit-${SETEDITVER}.tar.bz2
	http://dev.gentoo.org/~azarah/rhide/setedit-${SETEDITVER}.tar.bz2
	mirror://gnu/gdb/gdb-${GDBVER}.tar.bz2"
#	mirror://sourceforge/tvision/rhtvision-${TVISIONVER}.src.tar.gz
#	mirror://sourceforge/setedit/setedit-${SETEDITVER}.tar.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X aalib"

RDEPEND="virtual/libc
	>=dev-libs/libpcre-2.0.6
	>=app-arch/bzip2-1.0.1
	>=sys-apps/texinfo-4.1
	>=sys-devel/gettext-0.11.0
	>=dev-lang/perl-5.6
	>=sys-libs/zlib-1.1.4
	>=sys-libs/gpm-1.20.0
	>=sys-libs/ncurses-5.2
	aalib? ( media-libs/aalib )
	X? ( || ( ( x11-libs/libX11
		x11-libs/libXmu ) virtual/x11 ) )
	>=sys-apps/sed-4.0.7"
DEPEND="${RDEPEND}
	X? ( || ( x11-proto/xproto virtual/x11 ) )"

TV_S="${WORKDIR}/tvision"
SE_S="${WORKDIR}/setedit"

src_unpack() {
	unpack ${A}

	# Add support for amd64
	for x in "${S}" "${S}/libtvuti" ; do
		cd "${x}"
		epatch "${FILESDIR}/${P}-amd64-support.patch"
		autoconf
	done

	# Update snapshot version
	if [[ -n ${SNAPSHOT} ]] ; then
		sed -i -e "s|1998-11-29|${SNAPSHOT}|" "${S}/idemain.cc"
	else
		sed -i -e "s|1998-11-29|`date +%F`|" "${S}/idemain.cc"
	fi

	# Fix invalid "-O2" in CFLAGS and CXXFLAGS
	for x in configure \
	         $(find "${S}/" -name '*.mak') \
	         $(find "${S}/" -name 'makefile.src')
	do
		[[ -f ${x} ]] && sed -i -e 's:-O2::g' "${x}"
	done

	# Update setedit macro's
	for x in "${SE_S}/cfgfiles"/* ; do
		[[ -f ${x} ]] && cp -f "${x}" "${S}/share/setedit/"
	done

	# Lame attempt to rip out X11 detection
	if useq !X ; then
		einfo "Disabling X support"
		cp -f "${TV_S}/config.pl" "${TV_S}/config.pl.X11"
		sed -i -e \
			"s:\$conf{'HAVE_X11'}='yes':\$conf{'HAVE_X11'}='no':g" \
			"${TV_S}/config.pl"
		# Sanity check
		[[ -z $(diff -u "${TV_S}/config.pl" "${TV_S}/config.pl.X11") ]] \
			&& die "TVision's config.pl was not changed!"
	fi

	# Fix codepage bug
	has_version ">=sys-devel/gettext-0.12" && \
	sed -i -e \
		's:--add-location $(po_list_l):--add-location --from-code=iso-8859-1 $(po_list_l):' \
		"${SE_S}/internac/gnumake.in"

	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {

	# Most of these use a _very_ weird build systems,
	# so please no comments ;/

# ************* TVision *************

	if [[ ! -f ${WORKDIR}/.tvision ]] ; then
		cd "${TV_S}" || die "TVision source dir do not exist!"

		einfo "Configuring TVision ..."
		CC=$(tc-getCC) CXX=$(tc-getCXX) \
		./configure --prefix="/usr" \
			--x-include="/usr/include" \
			--x-lib="/usr/$(get_libdir)" \
			--fhs \
			--without-dynamic || die

		einfo "Building TVision ..."
		emake || die

		touch ${WORKDIR}/.tvision
	fi


# ************* SetEdit *************

	if [[ ! -f ${WORKDIR}/.setedit ]] ; then
		cd "${SE_S}" || die "SetEdit source dir do not exist!"

		einfo "Configuring SetEdit ..."
		CC=$(tc-getCC) CXX=$(tc-getCXX) \
		./configure --prefix=/usr \
			--fhs \
			--libset \
			--static \
			--without-mp3 \
			--without-mixer \
			--without-migdb \
			`use_with aalib aa` || die

		einfo "Building SetEdit ..."
		emake || die

		# Make the docs
		cd "${SE_S}/doc"
		make || die

		touch "${WORKDIR}/.setedit"
	fi


# ************* RHIDE ***************

	cd "${S}"

#	addpredict "/usr/share/rhide"

	export RHIDESRC="${S}"
	export SETSRC="${SE_S}"
	export SETOBJ="${SE_S}/makes"
	export TVSRC="${TV_S}"
	export TVOBJ="${TV_S}/makes"
	export GDB_SRC="${WORKDIR}/gdb-${GDBVER}"

	if [[ ! -f ${WORKDIR}/.rhide-configured ]] ; then
		einfo "Configuring RHIDE ..."
		CC=$(tc-getCC) CXX=$(tc-getCXX) \
		econf || die

		touch "${WORKDIR}/.rhide-configured"
	fi

	einfo "Building RHIDE ..."
	# For now 'make -jx' breaks building
	make CC=$(tc-getCC) CXX=$(tc-getCXX) \
		RHIDE_GCC=$(tc-getCC) \
		RHIDE_GXX=$(tc-getCXX) \
		prefix="/usr" \
		install_docdir="share/doc/${PF}" \
		install_infodir="share/info" || die

	# Update and Fix DIR entry in .info files
	if [[ -f ${SE_S}/doc/editor.inf ]] ; then
		sed -e 's:editor.inf:setedit.info:g' \
			"${SE_S}/doc/editor.inf" > "${S}/share/setedit/setedit.inf"
	fi
	if [[ -f ${SE_S}/doc/infeng.inf ]] ; then
		sed -e 's:infeng.inf:infview.info:g' \
			"${SE_S}/doc/infeng.inf" > "${S}/share/setedit/infview.inf"
	fi
}

src_install() {

	# Dont error out on sandbox violations.  I should really
	# try to track this down, but its a bit tougher than usually.
#	addpredict "/:/usr/share/rhide:/libide:/libtvuti:/librhuti"

	make prefix="${D}/usr" \
		install_docdir="share/doc/${PF}" \
		install_infodir="share/info" \
		install || die

	# Install default CFG file and fix the paths
	sed -e 's:/usr/local/share:/usr/share:g' \
		"${D}/usr/share/rhide/rhide_.env" > \
		"${D}/usr/share/rhide/rhide.env"
	echo 'INFOPATH=/usr/share/info' >> \
		"${D}/usr/share/rhide/rhide.env"

	# Install sample TVision config file
	insinto /etc
	doins "${FILESDIR}/tvrc"

	# Install env file
	doenvd "${FILESDIR}/80rhide"

	# We only need the Eterm stuff if TVision was not compiled
	# with X11 support ...
	if [[ ${ETERM_HACK} == "yes" ]] && useq !X ; then
		# Install the terminfo file
		tic -o "${D}/usr/share/terminfo" \
			"${TV_S}/extra/eterm/xterm-eterm-tv"
		insinto /usr/share/Eterm/themes/Setedit

		dosed 's:Eterm --title:Eterm --theme Setedit --title:' \
			/usr/bin/rhidex
		dosed 's:Eterm --title:Eterm --theme Setedit --title:' \
			/usr/bin/rhgdbx

		# Install the Eterm theme
		for x in "${TV_S}/extra/eterm/Setedit"/* ; do
			[[ -f ${x} ]] && doins "${x}"
		done
	else
		rm -f "${D}/usr/bin"/{rhide,rhgdb}x
	fi

	# Fix .info files
	for x in "${D}/usr/share/info"/*.inf ; do
		[[ -f ${x} ]] && mv -f "${x}" "${x}o"
	done

	# Install the manpages
	for x in "${SE_S}/doc"/*.1
	do
		[[ -f ${x} ]] && doman "${x}"
	done

	cd "${S}"
	dodoc todo
	cd "${TV_S}"
	docinto tvision
	dodoc THANKS TODO borland.txt change.log change1.log copying* readme.txt
	dodoc doc/*.{txt,html}
	cd "${SE_S}"
	docinto setedit
	dodoc README TODO change.log change0.log copyrigh* copying.*
}

pkg_postinst() {
	if [[ -x "${ROOT}/usr/bin/rhidex" && ${ETERM_HACK} == "yes" ]] ; then
		echo
		elog "You might consider installing Eterm to be able to use the rhidex"
		elog "version of RHIDE that have better keyboard support under X:"
		elog
		elog "  # emerge eterm"
		echo
	fi
}
