# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvfs2/pvfs2-2.7.0.ebuild,v 1.1 2007/12/03 00:00:45 nerdboy Exp $

inherit linux-mod autotools toolchain-funcs

MY_PN="${PN%[0-9]*}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Parallel Virtual File System version 2"
HOMEPAGE="http://www.pvfs.org/"
SRC_URI="ftp://ftp.parl.clemson.edu/pub/pvfs2/${MY_P}.tar.gz"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	sys-libs/db
	dev-libs/openssl
	apidocs? ( app-doc/doxygen )
	doc? ( dev-tex/latex2html
		virtual/tetex )"

DEPEND="${RDEPEND}
	virtual/linux-sources
	examples? ( dev-lang/perl )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="apidocs doc examples gtk server static"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
	    BUILD_TARGETS="just_kmod24"
	    ECONF_PARAMS="--with-kernel24=${KV_DIR}"
	    MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.4)"
	else
	    BUILD_TARGETS="just_kmod"
	    ECONF_PARAMS="--with-kernel=${KV_DIR} --enable-verbose-build"
	    MODULE_NAMES="pvfs2(fs::src/kernel/linux-2.6)"
	fi

	# Notice I don't include --disable-static because it makes the linker
	# fail due to a missing library needed by LIBS_THREADED += -lpvfs2-threaded.
	# However that library is only compiled if static is enabled. Anyway
	# it is used to build pvfs2-client-core-threaded, which is not installed 
	# by make kmod_install (unstable perhaps?)

	# As of version 2.7.0 both static and shared versions of lpvfs2-threaded
	# are built and installed (via the soname patch).  Feel free to test ...
	ECONF_PARAMS="${ECONF_PARAMS} $(use_enable !static shared)"
	ECONF_PARAMS="${ECONF_PARAMS} $(use_enable gtk karma)"
	ECONF_PARAMS="${ECONF_PARAMS} $(use_enable server)"
	ECONF_PARAMS="${ECONF_PARAMS} --libdir=/usr/$(get_libdir)"
	ECONF_PARAMS="${ECONF_PARAMS} --enable-mmap-racache"
	ECONF_PARAMS="${ECONF_PARAMS} --with-openssl=/usr"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find "${S}" -name '*\.d' | xargs rm -rf

	AT_M4DIR="maint/config" eautoreconf

	epatch "${FILESDIR}"/2.6.3-as-needed.patch || die "as-needed patch failed"
	epatch "${FILESDIR}/${PV}"-lib-install.patch || die "install patch failed"
	epatch "${FILESDIR}/${PV}"-soname.patch || die "soname patch failed"

	# Fix so we can install kernapps separate from kmod_install
	sed -i '/^kmod_install: kmod/{
		s/\(kmod_install:.*kernapps\)\(.*\)/\1_install\2\n.PHONY: kernapps_install\nkernapps_install: kernapps/}' Makefile.in
	sed -i '/^kmod24_install: kmod/{
		s/\(kmod24_install:.*kernapps\)\(.*\)/\1_install\2\n.PHONY: kernapps_install\nkernapps_install: kernapps/}' Makefile.in

	#This is needed when gcc doesn't support -Wno-pointer-sign. Now it will give us some warnings so it also removes -Werror.
	#It's unsafe, not recommended
	if [ "$(gcc-major-version)" -lt "4" ]; then
		ewarn "It's recommended to use gcc >= 4.0 to avoid the following patch"
		epatch "${FILESDIR}"/2.6.3-no-pointer-sign.patch
	fi
}

src_compile() {
	# since ${ECONF_PARAMS} is set, linux-mod_src_compile will invoke
	# its own configure, so running econf just makes it go twice...

	linux-mod_src_compile || die "Unable to linux-mod_src_compile"
	make kernapps || die "Unable to make kernapps."
	make all || die "Unable to make all."

	if use doc ; then
	     make docs || die "Unable to make docs."
	    if use apidocs ; then
		cd "${S}"/doc
		doxygen doxygen/pvfs2-doxygen.conf || die "doxygen failed"
	    fi
	fi
}

src_install() {
	linux-mod_src_install || die "linux-mod_src_install failed"
	emake DESTDIR="${D}" kernapps_install || die "kernapps_install failed"
	emake DESTDIR="${D}" install || die "install failed"

	cd "${D}"usr/$(get_libdir)
	dosym libpvfs2.so.2.0 /usr/$(get_libdir)/libpvfs2.so.2
	dosym libpvfs2.so.2 /usr/$(get_libdir)/libpvfs2.so
	dosym libpvfs2-threaded.so.2.0 /usr/$(get_libdir)/libpvfs2-threaded.so.2
	dosym libpvfs2-threaded.so.2 /usr/$(get_libdir)/libpvfs2-threaded.so
	cd "${S}"

	if use server; then
	    newinitd "${FILESDIR}"/pvfs2-server.rc pvfs2-server
	    newconfd "${FILESDIR}"/pvfs2-server.conf pvfs2-server
	fi

	newinitd "${FILESDIR}"/pvfs2-client-init.d pvfs2-client
	newconfd "${FILESDIR}"/pvfs2-client.conf pvfs2-client

	# this is LARGE (~5mb)
	if use doc; then
	    dodoc doc/multi-fs-doc.txt doc/add-server-req \
		doc/add-client-syscall doc/coding/valgrind \
		doc/coding/backtrace_analysis.txt
	    insinto /usr/share/doc/"${PF}"/
	    doins doc/*.pdf doc/coding/developer-guidelines.pdf \
		doc/design/*.pdf doc/random/SystemInterfaceTesting.pdf
	    if use apidocs ; then
		dohtml -A map -A md5 doc/doxygen/html/*
	    fi
	fi

	dodoc AUTHORS CREDITS ChangeLog INSTALL README
	docinto examples
	dodoc examples/{fs.conf,pvfs2-server.rc}
	if use examples ; then
	    insinto /usr/share/doc/"${PF}"/examples/heartbeat
	    doins examples/heartbeat/*
	fi
}

pkg_config () {
	elog "Creating new unified configuration file; if you have been"
	elog "running a previous version, you should run the conversion"
	elog "script instead.  See pvfs2-config-convert --help for more"
	elog "info."
	elog

	einfo ">>> Creating new unified config file - you may accept the"
	einfo ">>> defaults or adjust to suite your desired setup..."

	"${ROOT}"/usr/bin/pvfs2-genconfig "${ROOT}"/etc/pvfs2-fs.conf

	einfo
	einfo ">>> If this is the first time running the server, you must"
	einfo ">>> create the storage location first, which is part of the"
	einfo ">>> config you just specified above.  To do this, run the"
	einfo ">>> following command once as root, then start the server"
	einfo ">>> using the init script:"
	einfo "      /usr/sbin/pvfs2-server /etc/pvfs2-fs.conf -f"
	einfo
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst
	ewarn
	ewarn "You must convert your old config files or create a new one, so"
	ewarn "either emerge --config =${CATEGORY}/${PF} or run the supplied"
	ewarn "conversion script to complete the installation."
	ewarn
	ewarn "Note that libpvfs2-threaded.so is new and needs testing..."
	ewarn

	elog "To enable PVFS2 Server on boot you will have to add it to the"
	elog "default profile, issue the following command as root to do so."
	elog
	elog "rc-update add pvfs2-server default"
}

pkg_postrm() {
	linux-mod_pkg_postrm
	elog
	elog "If you're removing this package completely and the file"
	elog "/lib/modules/${KV_FULL}/fs/pvfs2.ko is still"
	elog "there, you'll have to remove it yourself."
}
