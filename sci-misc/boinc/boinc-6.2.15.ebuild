# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/boinc/boinc-6.2.15.ebuild,v 1.2 2008/11/27 19:49:18 scarabeus Exp $

EAPI="1"

inherit depend.apache flag-o-matic wxwidgets autotools

MY_PV="${PV//./_}"
DESCRIPTION="The Berkeley Open Infrastructure for Network Computing"
HOMEPAGE="http://boinc.ssl.berkeley.edu/"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2
		bindist? ( amd64? ( http://${PN}dl.ssl.berkeley.edu/dl/${P/-/_}_x86_64-pc-linux-gnu.sh )
					x86? ( http://${PN}dl.ssl.berkeley.edu/dl/${P/-/_}_i686-pc-linux-gnu.sh )
				)"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="X bindist server unicode"
# bindist is only for x86 and amd64 for rest package.use.mask

RDEPEND="sys-libs/zlib
	>=net-misc/curl-7.15.5
	>=dev-libs/openssl-0.9.7
	X? ( =x11-libs/wxGTK-2.8* )
	server? (
		!bindist? (
			>=virtual/mysql-4.0
			virtual/php
			>=dev-lang/python-2.2.3
			>=dev-python/mysql-python-0.9.2
		)
	)"
DEPEND="app-misc/ca-certificates
	!bindist? (
		>=sys-devel/gcc-3.0.4
		>=sys-devel/autoconf-2.58
		>=sys-devel/automake-1.8
		>=dev-util/pkgconfig-0.15
		>=sys-devel/m4-1.4
	)
	X? ( x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libX11
		x11-proto/xproto
		media-libs/freeglut
		virtual/glu
		media-libs/jpeg )
	server? ( !bindist? ( virtual/imap-c-client ) )
	${RDEPEND}"
# subversion is not needed only if user choose binary for amd64 or x86
want_apache server

LANGS="ar be bg ca cs da de el en_US es eu fi fr hr hu it ja lt lv nb nl pl pt pt_BR ro ru sk sl sv_SE tr uk zh_CN zh_TW"
for LNG in ${LANGS}; do
	IUSE="${IUSE} linguas_${LNG}"
done

src_unpack() {
	local target

	if ! use bindist; then
		unpack ${P}.tar.bz2
		cd "${S}"
		# replace CXXFLAGS, those added are suggested by upstream
		sed -i \
			-e "s:-O3 -fomit-frame-pointer -fforce-addr -ffast-math \$(AM_CPPFLAGS):\$(AM_CPPFLAGS) -O3 -funroll-loops -fforce-addr	-ffast-math:" \
			client/Makefile.am || die "sed client/Makefile.am failed"
		# silence warnings
		epatch "${FILESDIR}"/"${P}"-project-list-size.patch
		epatch "${FILESDIR}"/"${P}"-mute-warnings.patch
		# do autoreconf
		rm "${S}"/m4/libtool.m4
		AT_M4DIR="m4" eautoreconf
	else
		use server && elog "Server feature is working only for source build, please disable bindist if you really intend to use server."
		use x86 && target="i686" || target="x86_64"
		cp "${DISTDIR}"/${P/-/_}_${target}-pc-linux-gnu.sh "${WORKDIR}"
		cd "${WORKDIR}"
		sh ${P/-/_}_${target}-pc-linux-gnu.sh
	fi
	# patch up certificates
	mkdir "${S}"/curl/
	ln -s /etc/ssl/certs/ca-certificates.crt "${S}"/curl/ca-bundle.crt
	sed -i \
		-e "s:::g" \
		"${S}"/Makefile
}

src_compile() {
	if ! use bindist; then
		if use X; then
			WX_GTK_VER=2.8
			use unicode && need-wxwidgets unicode || need-wxwidgets gtk2
			wxconf="--with-wx-config=${WX_CONFIG}"
		fi

		econf \
			--enable-client \
			--with-ssl \
			${wxconf} \
			$(use_enable unicode) \
			$(use_enable server) \
			$(use_with X x) || die "econf failed"

		# Make it link to the compiled libs, not the installed ones
		# remove precompiled binaries from svn
		sed -i \
			-e "s:LDFLAGS = :LDFLAGS = -L../lib :g" \
			*/Makefile || die "sed failed"
		emake -j1 || die "emake failed"
	fi
}

src_install() {
	dodir /var/lib/${PN}
	newinitd "${FILESDIR}"/${PN}.init ${PN}
	newconfd "${FILESDIR}"/${PN}.conf ${PN}
	if ! use bindist; then
		make install DESTDIR="${D}" || die "make install failed"
		# icon
		newicon "${S}"/sea/${PN}mgr.48x48.png ${PN}.png
		# wrapper to allow gui to load gui_rpc_auth.cfg because ${PN} devs assume curdir to be datadir for ${PN}_gui
		mv "${D}"/usr/bin/${PN}_gui "${D}"/usr/bin/${PN}mgr
		echo "cd \"/var/lib/${PN}\" && exec /usr/bin/${PN}mgr \$@" > "${D}"/usr/bin/${PN}_gui
		chmod 755 "${D}"/usr/bin/${PN}_gui
		# desktop
		if use X; then
			make_desktop_entry ${PN}_gui ${PN} ${PN} "Education;Science" /var/lib/${PN}
		fi
		# required headers by seti@home
		insopts -m0644
		insinto /usr/include/${PN}
		doins "${S}"/api/{reduce.h,graphics_api.h,graphics_data.h,${PN}_gl.h}
		# symlink locale so it actualy work for source dist.
		insinto /usr/share/locale/
		cd "${S}"/locale/client
		for LNG in ${LINGUAS}; do
			doins -r ${LNG}
		done
		dosym /usr/share/locale /var/lib/${PN}/locale
		cd "${S}"
	else
		local S_BIN="${WORKDIR}"/BOINC
		cd "${S_BIN}"
		# fix ${PN}.conf file for binary package
		sed -i -e "s:/usr/bin/${PN}_client:/opt/${PN}/${PN}:g" "${D}"/etc/conf.d/${PN}
		if use X; then
			# icon
			newicon "${S_BIN}"/${PN}mgr.48x48.png ${PN}.png
			# desktop
			make_desktop_entry /opt/${PN}/run_manager "${PN}" ${PN} "Education;Science"	/var/lib/${PN}
		fi
		# use correct path in scripts
		sed -i \
			-e "s:${S_BIN}:/var/lib/${PN}:g" \
			-e "s:./${PN}:/opt/${PN}/${PN}:g" \
			run_client || die "sed run_client failed"
		sed -i \
			-e "s:${S_BIN}:/var/lib/${PN}:g" \
			-e "s:./${PN}mgr:/opt/${PN}/${PN}mgr:g" \
			run_manager || die "sed run_manager failed"
		# install binaries
		exeopts -m0755
		exeinto /opt/${PN}

		doexe "${S_BIN}"//{${PN},${PN}_cmd,${PN}cmd,${PN}mgr,run_client,run_manager}
		fowners 0:${PN} /opt/${PN}/{${PN},${PN}_cmd,${PN}cmd,${PN}mgr,run_client,run_manager}
		# locale
		mkdir -p "${D}"/opt/${PN}/locale
		insopts -m0644
		insinto /opt/${PN}/
		cd "${S_BIN}"/locale/
		for LNG in ${LINGUAS}; do
			doins -r "${LNG}"
		done
		dosym /opt/${PN}/locale /var/lib/${PN}/locale
		cd "${S}"
	fi
	dosym /etc/ssl/certs/ca-certificates.crt /var/lib/${PN}/ca-bundle.crt
	insopts -m0640
	insinto /var/lib/${PN}
	doins "${FILESDIR}"/gui_rpc_auth.cfg
	fowners ${PN}:${PN} /var/lib/${PN}/gui_rpc_auth.cfg
	fowners ${PN}:${PN} /var/lib/${PN}/
}

pkg_preinst() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

pkg_postinst() {
	echo
	if use bindist; then
		elog "You are using the binary distributed version."
		elog "The manager can be found at /opt/${PN}/run_manager"
	fi
	elog "You need to attach to a project to do anything useful with ${PN}."
	elog "You can do this by running /etc/init.d/${PN} attach"
	elog "${PN} The howto for configuration is located at:"
	elog "http://${PN}.berkeley.edu/anonymous_platform.php"
	if use server && ! use bindist ; then
		echo
		elog "You have chosen to enable server mode. this ebuild has installed"
		elog "the necessary packages to be a server. You will need to have a"
		elog "project. Contact ${PN} directly for further information."
	fi
	echo
	# Add warning about the new password for the client, bug 121896.
	elog "If you need to use the graphical client the password is in "
	elog "/var/lib/${PN}/gui_rpc_auth.cfg which is randomly generated "
	elog "by ${PN} upon successfully running the gui for the first time."
	elog "You can change this to something more memorable."
	echo
}
