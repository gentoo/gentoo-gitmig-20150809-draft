# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cfal/cfal-1.2.0.4.ebuild,v 1.6 2005/08/24 07:45:30 flameeyes Exp $

IUSE=""

DESCRIPTION="Compaq's enhanced Fortran compiler for the ALPHA platform"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"

# its okay to set a SRC_URI here, as the rpm is gpg encrypted
# and user must agree to the license before getting access
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/crypt/cfal-1.2.0-4.alpha.rpm.crypt
	ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/cfalrtl-1.2.0-3.alpha.rpm"

S=${WORKDIR}
LICENSE="PLDSPv2"
SLOT="0"
# NOTE: ALPHA Only!
KEYWORDS="-* ~alpha"

RDEPEND="virtual/libc
	dev-libs/libots
	>=dev-libs/libcpml-5.2.01-r2
	dev-libs/libcxml"

DEPEND="${RDEPEND}
	sys-devel/gcc-config
	app-arch/rpm2targz
	>=sys-apps/sed-4
	app-crypt/gnupg
	>=app-shells/bash-2.05b"

# These variables are not used by Portage, but is used by the functions
# below.
cfal_release="1.2.0-4"
cfalrtl_release="1.2.0-3"
ee_license_reg="http://h18000.www1.hp.com/products/software/alpha-tools/ee-license.html"

src_unpack() {
	# convert rpm into tar archive
	local cfal_rpm="cfal-${cfal_release}.alpha.rpm"
	local cfalrtl_rpm="cfalrtl-${cfalrtl_release}.alpha.rpm"

	if [ -z ${CFAL_LICENSE_KEY} ]; then
		eerror ""
		eerror "You have not set the environment variable"
		eerror "\$CFAL_LICENSE_KEY, this should be set to"
		eerror "the password you were sent when you applied"
		eerror "for your alpha-tools enthusiast/educational"
		eerror "license."
		eerror "If you do not have a license key, apply for one"
		eerror "here ${ee_license_reg}"
		eerror ""
		die "no license key in \$CFAL_LICENSE_KEY"
	fi

	# :-NULL safeguards against bash bug.
	einfo "Decrypting cfal distribution..."
	echo ${CFAL_LICENSE_KEY} | gpg --quiet \
		--homedir=${T} --no-permission-warning \
		--no-mdc-warning \
		--passphrase-fd 0 \
		--output ${cfal_rpm} \
		--decrypt ${DISTDIR}/${cfal_rpm}.crypt

	ebegin "Unpacking cfal distribution..."
	# This is the same as using rpm2targz then extracting 'cept that
	# it's faster, less work, and less hard disk space.  rpmoffset is
	# provided by the rpm2targz package.
	i=${cfal_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx

	i=${DISTDIR}/${cfalrtl_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx

	eend ${?}
	assert "Failed to extract either ${cfal_rpm%.rpm}.tar.gz or ${cfalrtl_rpm%.rpm}.tar.gz"
}

src_compile() {
	# shuffling around some directories
	einfo "Fixing permissions..."
	chown -R root:0 ${S}/usr ${S}/lib
	chmod 755 ${S}/lib

	einfo "Fixing man pages..."
	mkdir ${S}/usr/share
	rm -rf ${S}/usr/man
	mv ${S}/usr/lib/compaq/cfal-1.2.0/man ${S}/usr/share

	mv ${S}/usr/doc/cfal-1.2.0/README ${S}/usr/doc/cfal-1.2.0/fort.man \
		${S}/usr/doc/cfal-1.2.0/decfortran90.hlp ${S}
	rm -rf ${S}/usr/doc

	# fix up lib paths - bug #15719, comment 6
	einfo "Copying crtbegin/crtend from gcc..."
	gcc_libs_path="`gcc-config --get-lib-path`"
	if [ $? != 0 ] || [ ! -d "${gcc_libs_path}" ]; then
		die "gcc-config returned an invalid library path (${gcc_libs_path})"
	else
		cp -f ${gcc_libs_path}/crt{begin,end}.o usr/lib/compaq/cfal
		assert "Failed to copy crtbegin/crtend.o from ${gcc_libs_path}"
	fi
}

src_install() {
	# move files over
	mv usr ${D} || die "cfal installation failed"

	dodoc README fort.man decfortran90.hlp

	dodir /lib
	dosym /usr/lib/compaq/cfal/fpp /lib/fpp

	prepalldocs
	prepallman
}

pkg_postinst () {
	einfo
	einfo "cfal has been merged successfully, the EULA"
	einfo "is available in"
	einfo
	einfo "/usr/share/doc/${PF}/README"
	einfo
}
