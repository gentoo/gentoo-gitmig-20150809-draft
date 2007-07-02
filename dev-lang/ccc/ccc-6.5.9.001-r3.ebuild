# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ccc/ccc-6.5.9.001-r3.ebuild,v 1.7 2007/07/02 14:39:33 peper Exp $
#
# Ebuild contributed by Tavis Ormandy <taviso@sdf.lonestar.org>
# and edited by Aron Griffis <agriffis@gentoo.org>

inherit eutils rpm

IUSE="doc"

DESCRIPTION="Compaq's enhanced C compiler for the ALPHA platform"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"

# no need to add fetch restrictions, as the rpm is gpg encrypted
# and user must agree to the license before getting access
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/crypt/ccc-6.5.9.001-6.alpha.rpm.crypt"

S=${WORKDIR}
LICENSE="PLDSPv2"
SLOT="0"
KEYWORDS="-* ~alpha"

RDEPEND="virtual/libc
	dev-libs/libots
	>=dev-libs/libcpml-5.2.01-r2"

DEPEND="${RDEPEND}
	sys-devel/gcc-config
	>=sys-apps/sed-4
	app-crypt/gnupg
	>=app-shells/bash-2.05b"

RESTRICT="strip"

# These variables are not used by Portage, but by the functions
# below.
ccc_release="${PV}-6"
ee_license_reg="http://h18000.www1.hp.com/products/software/alpha-tools/ee-license.html"

src_unpack() {
	# convert rpm into tar archive
	local ccc_rpm="ccc-${ccc_release}.alpha.rpm"

	if [ -z ${CCC_LICENSE_KEY} ]; then
		eerror
		eerror "You have not set the environment variable"
		eerror "\$CCC_LICENSE_KEY, this should be set to"
		eerror "the password you were sent when you applied"
		eerror "for your alpha-tools enthusiast/educational"
		eerror "license."
		eerror "If you do not have a license key, apply for one"
		eerror "here ${ee_license_reg}"
		eerror
		die "no license key in \$CCC_LICENSE_KEY"
	fi

	einfo "Decrypting ccc distribution..."
	gpg --quiet \
		--homedir=${T} --no-permission-warning \
		--no-mdc-warning \
		--passphrase-fd 0 \
		--output ${ccc_rpm} \
		--decrypt ${DISTDIR}/${ccc_rpm}.crypt <<< ${CCC_LICENSE_KEY:-NULL} || die "failed to secrypt ccc distribution"

	ebegin "Unpacking ccc distribution..."
	rpm_unpack ${ccc_rpm}
	eend ${?}
	assert "Failed to extract ${ccc_rpm%.rpm}.tar.gz"

	find ${S}/usr -type d -exec chmod a+rx {} \;

	# patch up config script to sort gcc-lib paths last.  Thanks to
	# Marc Giger for sorting this out
	epatch ${FILESDIR}/create-comp-config.patch

	# remove unwanted documentation
	if ! use doc; then
		einfo "Removing unwanted documentation (USE=\"-doc\")..."
		rm -rf usr/doc
	fi

	# Patch create-comp-config.sh to work with gcc-3.x
	# (06 Feb 2004 agriffis)
	sed -i -e 's/gcc -v -V \$GCC_VER/gcc -V $GCC_VER -v/' \
		usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/create-comp-config.sh

	# man pages are in the wrong place
	einfo "Reorganising man structure..."
	rm -rf usr/man
	mkdir usr/share
	mv usr/lib/compaq/ccc-${ccc_release}/alpha-linux/man usr/share

	if use doc; then
		einfo "Reorganising documentation..."
		mv usr/doc usr/share
	fi
}

src_compile() {
	true  # nothing to compile
}

src_install() {
	# move files over
	mv usr ${D} || die "ccc installation failed"

	# prep manpages
	prepman ${D}/usr/share/man/man1/ccc.1
	prepman ${D}/usr/share/man/man8/protect_headers_setup.8
	prepalldocs

	# install ccc proxy until config is executed
	mv ${D}/usr/bin/ccc{,.real}
	cat >${D}/usr/bin/ccc <<EOF
#!/bin/sh
echo "Error: ccc must be configured before compiling!" >&2
echo "The system administrator must run the following command:" >&2
echo "  emerge --config =${CATEGORY}/${PF}" >&2
exit 1
EOF
	chmod 0755 ${D}/usr/bin/ccc
}

pkg_config () {
	einfo "Copying crtbegin/crtend from gcc"
	local gcc_libs_path="`gcc-config --get-lib-path`"
	if [[ $? != 0 || ! -d "${gcc_libs_path}" ]]; then
		die "gcc-config returned an invalid library path (${gcc_libs_path})"
	else
		rm -f /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/crt{begin,end}.o
		cp ${gcc_libs_path}/crt{begin,end}.o \
			/usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin
		assert "Failed to copy crtbegin/crtend.o from ${gcc_libs_path}"
	fi

	# Need the real ccc prior to configuration
	if [[ -f /usr/bin/ccc.real ]]; then
		einfo "Moving ccc.real into place"
		rm -f /usr/bin/ccc
		mv /usr/bin/ccc.real /usr/bin/ccc
		assert "failed to rename ccc.real"
	fi

	einfo "Attempting configuration of ccc"
	# NOTE: _must_ hide distcc, ccache, etc during this step
	PATH=/bin:/usr/bin:/sbin:/usr/sbin \
	  /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/create-comp-config.sh \
	  ccc-${ccc_release} ${gcc_libs_path}
	echo

	einfo "ccc has been configured, you can now use it as usual."
}

pkg_postinst () {
	echo
	elog "ccc has been merged successfully, the EULA"
	elog "is available in"
	elog
	elog "/usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/LICENSE.txt"
	elog
	if use doc >/dev/null; then
		elog "You can also view the compiler documentation"
		elog "in /usr/share/doc/ccc-${PV}"
	fi

	echo
	elog "Hopefullly soon we will get a ccc USE flag"
	elog "on packages (or at least individual"
	elog "components) that can be successfully built"
	elog "using this compiler, until then you will"
	elog "just have to experiment :)"
	elog
	elog "Please report successes/failures with ccc"
	elog "to http://bugs.gentoo.org so that the USE"
	elog "flags can be updated."
	elog

	echo
	ewarn
	ewarn "You _MUST_ now run:"
	ewarn "emerge --config =${CATEGORY}/${PF}"
	ewarn "to complete the installation"
	ewarn

	echo
}
