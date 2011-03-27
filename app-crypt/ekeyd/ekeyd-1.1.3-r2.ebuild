# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ekeyd/ekeyd-1.1.3-r2.ebuild,v 1.1 2011/03/27 21:56:08 flameeyes Exp $

EAPI=2

inherit multilib linux-info toolchain-funcs

DESCRIPTION="Entropy Key userspace daemon"
HOMEPAGE="http://www.entropykey.co.uk/"
SRC_URI="http://www.entropykey.co.uk/res/download/${P}.tar.gz"

LICENSE="as-is" # yes, truly

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="usb kernel_linux"

RDEPEND="dev-lang/lua
	usb? ( virtual/libusb:0 )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	dev-lua/luasocket
	kernel_linux? ( sys-fs/udev )
	usb? ( !kernel_linux? ( sys-apps/usbutils ) )"

CONFIG_CHECK="~USB_ACM"

pkg_setup() {
	if use kernel_linux && ! use usb && linux_config_exists; then
		check_extra_config
	fi
}

src_prepare() {
	# - avoid using -Werror;
	# - don't gzip the man pages, this will also stop it from
	#   installing them, so we'll do it by hand.
	sed -i \
		-e 's:-Werror::' \
		-e '/gzip/d' \
		daemon/Makefile || die

	epatch "${FILESDIR}"/${PN}-1.1.1-earlyboot.patch
	epatch "${FILESDIR}"/${P}-libusb_compat.patch
	epatch "${FILESDIR}"/${P}-slashes.patch

	# Stupid multilib hack; remove it once Gentoo has sane paths for
	# udev directories.
	if [[ $(get_libdir) != lib ]]; then
		sed -i -e "s:/lib/udev/:/$(get_libdir)/udev/:" \
			doc/*.rules || die
	fi

	# We moved the binaries around
	sed -i -e 's:$BINPATH/ekey-ulusbd:/usr/libexec/ekey-ulusbd:' \
		doc/ekeyd-udev || die
}

src_compile() {
	local osname

	# Override automatic detection: upstream provides this with uname,
	# we don't like using uname.
	case ${CHOST} in
		*-linux-*)
			osname=linux;;
		*-freebsd*)
			osname=freebsd;;
		*-kfrebsd-gnu)
			osname=gnukfreebsd;;
		*-openbsd*)
			osname=openbsd;;
		*)
			die "Unsupported operating system!"
			;;
	esac

	# We don't slot LUA so we don't really need to have the variables
	# set at all.
	emake -C daemon \
		CC="$(tc-getCC)" \
		LUA_V= LUA_INC= \
		OSNAME=${osname} \
		OPT="${CFLAGS}" \
		BUILD_ULUSBD=$(use usb && echo yes || echo no) \
		|| die "emake failed"
}

src_install() {
	emake -C daemon \
		DESTDIR="${D}" \
		BUILD_ULUSBD=$(use usb && echo yes || echo no) \
		install || die "emake install failed"

	# We move the daemons around to avoid polluting the available
	# commands.
	dodir /usr/libexec
	mv "${D}"/usr/sbin/ekey*d "${D}"/usr/libexec

	# Install them manually because we don't want them gzipped
	doman daemon/{ekeyd,ekey-setkey,ekey-rekey,ekeydctl}.8 \
		daemon/ekeyd.conf.5 || die

	newinitd "${FILESDIR}"/${PN}.init ${PN} || die

	if use usb; then
		if ! use kernel_linux; then
			newinitd "${FILESDIR}"/ekey-ulusbd.init ekey-ulusbd || die
			newconfd "${FILESDIR}"/ekey-ulusbd.conf ekey-ulusbd || die
		fi
		doman daemon/ekey-ulusbd.8 || die
	fi

	dodoc daemon/README* AUTHORS WARNING ChangeLog || die

	if use kernel_linux; then
		local rules=doc/60-UDEKEY01.rules
		use usb && rules=doc/60-UDEKEY01-UDS.rules

		insinto /$(get_libdir)/udev/rules.d
		newins ${rules} 70-${PN}.rules || die

		exeinto /$(get_libdir)/udev
		doexe doc/ekeyd-udev || die
	fi
}

pkg_postinst() {
	elog "To make use of your entropykey, make sure to execute ekey-rekey"
	elog "the first time, and then start the ekeyd service."
	elog ""
	elog "The service supports multiplexing if you wish to use multiple"
	elog "keys, just symlink /etc/init.d/ekeyd → /etc/init.d/ekeyd.identifier"
	elog "and it'll be looking for /etc/init.d/identifier.conf"
	elog ""
	elog "If you intend on providing entropy for more than your running host"
	elog "you'll have to set the ekeyd daemon into EGD-server mode, and install"
	elog "on both the ekey host and the clients the app-crypt/ekey-egd-linux"
	elog "package that connects to the egd socket to receive entropy."
	elog ""

	if use usb; then
		if use kernel_linux; then
			elog "You're going to use the userland USB daemon, the udev rules"
			elog "will be used accordingly. If you want to use the CDC driver"
			elog "please disable the usb USE flag."
		else
			elog "You're going to use the userland USB daemon, since your OS"
			elog "does not support udev, you should start the ekey-ulusbd"
			elog "service before ekeyd."
		fi
	else
		if use kernel_linux; then
			elog "Some versions of Linux have a faulty CDC ACM driver that stops"
			elog "EntropyKey from working properly; please check the compatibility"
			elog "table at http://www.entropykey.co.uk/download/"
		else
			elog "Make sure your operating system supports the CDC ACM driver"
			elog "or otherwise you won't be able to use the EntropyKey."
		fi
		elog ""
		elog "If you're unsure about the working state of the CDC ACM driver"
		elog "enable the usb USE flag and use the userland USB daemon"
	fi
}
