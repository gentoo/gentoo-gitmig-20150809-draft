# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ccc/ccc-6.5.9.001-r1.ebuild,v 1.1 2004/02/07 02:27:36 agriffis Exp $
#
# Ebuild contributed by Tavis Ormandy <taviso@sdf.lonestar.org>
# and edited by Aron Griffis <agriffis@gentoo.org>

IUSE="doc"

DESCRIPTION="Compaq's enhanced C compiler for the ALPHA platform"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"

# its okay to set a SRC_URI here, as the rpm is gpg encrypted
# and user must agree to the license before getting access
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/crypt/ccc-6.5.9.001-6.alpha.rpm.crypt"

S=${WORKDIR}
LICENSE="PLDSPv2"
SLOT="0"
# NOTE: ALPHA Only!
KEYWORDS="-* alpha"

RDEPEND="virtual/glibc
	dev-libs/libots
	>=dev-libs/libcpml-5.2.01-r2"

DEPEND="${RDEPEND}
	sys-devel/gcc-config
	app-arch/rpm2targz
	>=sys-apps/sed-4
	app-crypt/gnupg
	>=app-shells/bash-2.05b
	>=dev-libs/libcpml-5.2.01-r2
	"

# These variables are not used by Portage, but is used by the functions
# below.
ccc_release="${PV}-6"
ee_license_reg="http://h18000.www1.hp.com/products/software/alpha-tools/ee-license.html"

src_unpack() {
	# convert rpm into tar archive
	local ccc_rpm="ccc-${ccc_release}.alpha.rpm"

	if [ -z ${CCC_LICENSE_KEY} ]; then
		eerror ""
		eerror "You have not set the environment variable"
		eerror "\$CCC_LICENSE_KEY, this should be set to"
		eerror "the password you were sent when you applied"
		eerror "for your alpha-tools enthusiast/educational"
		eerror "license."
		eerror "If you do not have a license key, apply for one"
		eerror "here ${ee_license_reg}"
		eerror ""
		die "no license key in \$CCC_LICENSE_KEY"
	fi

	# :-NULL safeguards against bash bug.
	einfo "Decrypting ccc distribution..."
	gpg --quiet \
		--homedir=${T} --no-permission-warning \
		--no-mdc-warning \
		--passphrase-fd 0 \
		--output ${ccc_rpm} \
		--decrypt ${DISTDIR}/${ccc_rpm}.crypt \
		<<< ${CCC_LICENSE_KEY:-NULL}

	ebegin "Unpacking ccc distribution..."
	# This is the same as using rpm2targz then extracting 'cept that
	# it's faster, less work, and less hard disk space.  rpmoffset is
	# provided by the rpm2targz package.
	i=${ccc_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx
	eend ${?}
	assert "Failed to extract ${ccc_rpm%.rpm}.tar.gz"

	# remove unwanted documentation
	if ! use doc >/dev/null; then
		einfo "Removing unwanted documentation (USE=\"-doc\")..."
		rm -rf usr/doc
	fi

# Moved the following step to pkg_config
# (06 Feb 2004 agriffis)
#
#	# fix up lib paths - bug #15719, comment 6
#	einfo "Copying crtbegin/crtend from gcc..."
#	gcc_libs_path="`gcc-config --get-lib-path`"
#	if [ $? != 0 ] || [ ! -d "${gcc_libs_path}" ]; then
#		die "gcc-config returned an invalid library path (${gcc_libs_path})"
#	else
#		cp -f ${gcc_libs_path}/crt{begin,end}.o \
#			usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin
#		assert "Failed to copy crtbegin/crtend.o from ${gcc_libs_path}"
#	fi

# Removed the following step in favor of create-comp-config.sh in pkg_config
# (06 Feb 2004 agriffis)
#
#	# add gcc-lib path to ccc's search path
#	# check man ccc for file format info.
#	einfo "Configuring ccc to observe gcc library path and include paths..."
#	printf '%s %s %s\n' \
#		"-L${gcc_libs_path}" \
#		" -SysIncDir /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/include" \
#		" -SysIncDir /usr/include/linux" \
#		> usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/comp.config
#	einfo "Additional paths can be set by users using \$DEC_CC variable."

	# Patch create-comp-config.sh to work with gcc-3.x
	# (06 Feb 2004 agriffis)
	sed -i -e 's/gcc -v -V \$GCC_VER/gcc -V $GCC_VER -v/' \
		usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/create-comp-config.sh

	# man pages are in the wrong place
	einfo "Reorganising man structure..."
	rm -rf usr/man
	mkdir usr/share
	mv usr/lib/compaq/ccc-${ccc_release}/alpha-linux/man usr/share

	if use doc >/dev/null; then
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
echo "  ebuild /var/db/pkg/dev-lang/${PF}/${PF}.ebuild config" >&2
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
	echo '<------- Begin ccc configuration output ------->'
	# NOTE: _must_ hide distcc, ccache, etc during this step
	PATH=/bin:/usr/bin:/sbin:/usr/sbin \
	  /usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/create-comp-config.sh \
	  ccc-${ccc_release} ${gcc_libs_path}
	echo '<------- End ccc configuration output ------->'
	echo

	einfo "ccc has been configured, you can now use it as usual."
}

pkg_postinst () {
	echo
	einfo "ccc has been merged successfully, the EULA"
	einfo "is available in"
	einfo
	einfo "/usr/lib/compaq/ccc-${ccc_release}/alpha-linux/bin/LICENSE.txt"
	einfo
	if use doc >/dev/null; then
		einfo "You can also view the compiler documentation"
		einfo "in /usr/share/doc/ccc-${PV}"
	fi

	echo
	einfo "Hopefullly soon we will get a ccc USE flag"
	einfo "on packages (or at least individual       "
	einfo "components) that can be successfully built"
	einfo "using this compiler, until then you will  "
	einfo "just have to experiment :)                "
	einfo
	einfo "Please report successes/failures with ccc "
	einfo "to http://bugs.gentoo.org so that the USE "
	einfo "flags can be updated.                     "
	einfo

	echo
	ewarn
	ewarn "You _MUST_ now run:"
	ewarn "ebuild /var/db/pkg/dev-lang/${PF}/${PF}.ebuild config"
	ewarn "to complete the installation"
	ewarn

	echo
}
