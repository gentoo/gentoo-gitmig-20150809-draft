# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cxx/cxx-6.5.9.31-r1.ebuild,v 1.2 2003/04/18 18:09:05 taviso Exp $
#
# Ebuild contributed by Tavis Ormandy <taviso@sdf.lonestar.org>
# and edited by Aron Griffis <agriffis@gentoo.org>

IUSE="doc"

DESCRIPTION="Compaq's enhanced C++ compiler for the ALPHA platform"
HOMEPAGE="http://www.support.compaq.com/alpha-tools"

# SRC_URI is included, but the rpm is encrypted with gpg
# Users must apply for an enthusiast/educational license to
# unlock the file.
SRC_URI="ftp://ftp.compaq.com/pub/products/linuxdevtools/latest/crypt/cxx-6.5.9.31-1.alpha.rpm.crypt"

S=${WORKDIR}
LICENSE="PLDSPv2"
SLOT="0"
# NOTE: ALPHA Only!
KEYWORDS="-* ~alpha"

DEPEND="sys-devel/gcc-config
	app-arch/rpm2targz
	>=sys-apps/sed-4
	app-crypt/gnupg
	>=app-shells/bash-2.05b
	>=dev-libs/libcpml-5.2.01-r2
	dev-libs/libots"

RDEPEND="virtual/glibc
	dev-libs/libots
	>=dev-libs/libcpml-5.2.01-r2"

# The variables below are not used by Portage, but are used by the functions
# below.
cxx_release="${PV}-1"
ee_license_reg="http://h18000.www1.hp.com/products/software/alpha-tools/ee-license.html"

src_unpack() {
	# convert rpm into tar archive
	local cxx_rpm="cxx-${cxx_release}.alpha.rpm"

	if [ -z ${CXX_LICENSE_KEY} ]; then
		eerror ""
		eerror "You have not set the environment variable"
		eerror "\$CXX_LICENSE_KEY, this should be set to"
		eerror "the password you were sent when you applied"
		eerror "for your alpha-tools enthusiast/educational"
		eerror "license."
		eerror "If you do not have a license key, apply for one"
		eerror "here ${ee_license_reg}"
		eerror ""
		die "no license key in \$CXX_LICENSE_KEY"
	fi
	
	# :-NULL safeguards against bash bug.
	einfo "Decrypting cxx distribution..."
        gpg --quiet \
                --homedir=${T} --no-permission-warning \
                --no-mdc-warning \
                --passphrase-fd 0 \
                --output ${cxx_rpm} \
                --decrypt ${DISTDIR}/${cxx_rpm}.crypt \
                <<< ${CXX_LICENSE_KEY:-NULL}
        
	ebegin "Unpacking cxx distribution..."
	# This is the same as using rpm2targz then extracting 'cept that
	# it's faster, less work, and less hard disk space.  rpmoffset is
	# provided by the rpm2targz package.
	i=${cxx_rpm}
	dd ibs=`rpmoffset < ${i}` skip=1 if=$i 2>/dev/null \
		| gzip -dc | cpio -idmu 2>/dev/null \
		&& find usr -type d -print0 | xargs -0 chmod a+rx \
		&& chmod -R g-w usr && chown -R root:root usr
	eend ${?}
	assert "Failed to unpack ${cxx_rpm}"
}

src_compile() {
	# remove unwanted documentation
	if ! use doc >/dev/null; then
		einfo "Removing unwanted documentation (USE=\"-doc\")..."
		rm -rf usr/doc
	fi

	# fix up lib paths - bug #15719, comment 6
	einfo "Copying crtbegin/crtend from gcc..."
	gcc_libs_path="`gcc-config --get-lib-path`"
	if [ $? != 0 ] || [ ! -d "${gcc_libs_path}" ]; then
		die "gcc-config returned an invalid library path (${gcc_libs_path})"
	else
		cp -f ${gcc_libs_path}/crt{begin,end}.o \
			usr/lib/compaq/cxx-${cxx_release%*-1}/alpha-linux/bin
		assert "Failed to copy crtbegin/crtend.o from ${gcc_libs_path}"
	fi

	# add gcc-lib path to cxx's search path
	# check man cxx for file format info.
	einfo "Configuring cxx to observe gcc library path and include paths..."
	printf '%s %s %s\n' \
		"-L${gcc_libs_path}" \
		" -SysIncDir /usr/lib/compaq/cxx-${cxx_releasei%*-1}/alpha-linux/include" \
		" -SysIncDir /usr/include/linux" \
		> usr/lib/compaq/cxx-${cxx_release%*-1}/alpha-linux/bin/comp.config
	einfo "Additional paths can be set by users using \$DEC_CXX variable."

	# man pages are in the wrong place
	einfo "Reorganising man structure..."
	rm -rf usr/man
	mv usr/lib/compaq/cxx-${cxx_release%*-1}/alpha-linux/man usr/share

	if use doc >/dev/null; then
		einfo "Reorganising documentation..."
		mv usr/doc usr/share
	fi

	# fix the probing script to ignore the version of libcpml.  This
	# is the wrong approach, but it will do for the first pass at this
	# package
	#
	# update: No longer nescessary with >=libcpml-5.2.01-r2 
	#
	#sed -i 's/^  version_high_enough /  true /' \
	#	usr/lib/compaq/cxx-${cxx_release}/alpha-linux/bin/probe_linux.sh
}

src_install() {
	# move files over
	mv usr ${D} || die "cxx installation failed"

	# prep manpages
	prepallman
	prepalldocs
}

pkg_config () {
	# some information for users
	einfo
	einfo "Attempting configuration of CXX..."
	einfo
	echo
	echo '<------- Begin cxx configuration output ------->'
	# NOTE: _must_ hide distcc, ccache, etc during this step
	PATH=/bin:/usr/bin:/sbin:/usr/sbin \
		/usr/lib/compaq/cxx-${cxx_release%*-1}/alpha-linux/bin/create-comp-config.sh \
		cxx-${cxx_release%*-1} ${gcc_libs_path}
	echo '<------- End cxx configuration output ------->'
	echo
	einfo
	einfo "cxx has been configured, you can now use it as usual."
	einfo
}

pkg_postinst () {
	einfo
	einfo "cxx has been merged successfully, the EULA"
	einfo "is available in"
	einfo
	einfo "/usr/lib/compaq/cxx-${cxx_release%*-1}/alpha-linux/bin/LICENSE.TXT"
	einfo
	if use doc >/dev/null; then
		einfo "You can also view the compiler documentation"
		einfo "in /usr/share/doc/cxx-${PV}"
	fi
	ewarn
	ewarn "you _MUST_ now run:"
	ewarn "ebuild /var/db/pkg/dev-lang/${PF}/${PF}.ebuild config"
	ewarn "to complete the installation"
	ewarn
	einfo "Hopefullly soon we will get a ccc USE flag"
	einfo "on packages (or at least individual       "
	einfo "components) that can be successfully built"
	einfo "using this compiler, until then you will  "
	einfo "just have to experiment :)                "
	einfo
	einfo "Please report successes/failures with cxx "
	einfo "to http://bugs.gentoo.org so that the USE "
	einfo "flags can be updated.                     "
	einfo
}
