# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/module-init-tools/module-init-tools-0.9.10-r4.ebuild,v 1.2 2003/05/25 15:21:01 mholzer Exp $

# This includes backwards compatability for stable kernels
IUSE=""

inherit flag-o-matic

inherit eutils

# Ok, theory of what we are doing is this:  modprobe from modutils
# later than 2.4.21 have hardcoded 'above' and 'below' stuff that
# cause generate-modprobe.conf to generate a /etc/modprobe.conf with
# invalid (linux-2.4) modules in it.
#
# Now, one solution is to only use modutils-2.4.21, but then we might
# cause issues for users that still use 2.4 kernels, as later modutils
# might fix things ...
#
# Solution:  build insmod two times, once without the predefined 'above'
#            and 'below' stuff, and install insmod as /sbin/modprobe.conf,
#            and second time build current modutils as we would.  Then we
#            tweak generate-modprobe.conf to rather use /sbin/modprobe.conf
#            to generate /etc/modprobe.conf ...
#
# <azarah@gentoo.org> (10 March 2003)

MYP="${P/_pre1/-pre}"
S="${WORKDIR}/${MYP}"
MODUTILS_PV="2.4.22"
DESCRIPTION="Kernel module tools for the development kernel >=2.5.48"
SRC_URI="mirror://kernel/linux/kernel/people/rusty/modules/${MYP}.tar.bz2
	mirror://kernel/linux/utils/kernel/modutils/v2.4/modutils-${MODUTILS_PV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/rusty/modules"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/devfsd-1.3.25-r1
	>=sys-kernel/development-sources-2.5.48"

pkg_setup() {
	check_KV

	if [ ! -f /lib/modules/${KV}/modules.dep ]
	then
		eerror "Please compile and install a kernel first!"
		die "Please compile and install a kernel first!"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Fix recursive calls to modprobe not honoring -s, -q, -v and -C
	epatch ${FILESDIR}/${P}-fix-recursion.patch
	# Never output to stdout if logging was requested
	epatch ${FILESDIR}/${P}-no-stdout-on-log.patch
	
	# Use modprobe without 'above'/'below' stuff that we install as modprobe.conf
	# when calling generate-modprobe.conf, as the newer modprobe (2.4.22 and later)
	# generate /etc/modprobe.conf with invalid modules ...
	epatch ${FILESDIR}/${P}-use-modprobe_conf.patch
	# For the first run we will build insmod without the predefined
	# 'above' and 'below' stuff.
	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	epatch ${FILESDIR}/modutils-${MODUTILS_PV}-no-above-below.patch
	cd ${S}

	# If we call modprobe with '-C /dev/modules.conf' and the "module name"
	# starts with '/dev', modprobe from modutils-2.4.22 do not print any
	# errors:
	#
	#   gateway root # modprobe /dev/sd1   
	#   modprobe: Can't locate module /dev/sd1
	#   gateway root # modprobe -C /etc/modules.conf /dev/sd1
	#   modprobe: Can't locate module /dev/sd1
	#   gateway root # modprobe -C /etc/modules.devfs /dev/sd1
	#   gateway root # modprobe foo     
	#   modprobe: Can't locate module foo
	#   gateway root # modprobe -C /etc/modules.conf foo     
	#   modprobe: Can't locate module foo
	#   gateway root # modprobe -C /etc/modules.devfs foo     
	#   modprobe: Can't locate module foo
	#   gateway root # 
	#   gateway root # modprobe -C /etc/modules.devfs /dev/sd1 && echo yes
	#   yes
	#   gateway root # modprobe -C /etc/modules.devfs foo && echo yes
	#   modprobe: Can't locate module foo
	#   gateway root # 
	epatch ${FILESDIR}/${P}-be-quiet-for-devfsd.patch
}

src_compile() {
	local myconf=
	
	filter-flags -fPIC

	einfo "Building modutils..."
	cd ${WORKDIR}/modutils-${MODUTILS_PV}

	econf \
		--disable-strip \
		--prefix=/ \
		--enable-insmod-static \
		--disable-zlib \
		${myconf}
	
	emake || die "emake modultils failed"

	# Ok, now create the real insmod
	mv -f insmod/insmod insmod/modprobe.conf
	EPATCH_OPTS="-R" \
	epatch ${FILESDIR}/modutils-${MODUTILS_PV}-no-above-below.patch

	emake || die "emake modultils failed"

	einfo "Building module-init-tools..."
	cd ${S}

	econf \
		--prefix=/ \
		${myconf}

	emake || die "emake module-init-tools failed"
}

src_install () {

	cd ${WORKDIR}/modutils-${MODUTILS_PV}
	einstall prefix="${D}"

	# Install /sbin/modprobe.conf used by generate-modprobe.conf
	exeinto /sbin
	doexe insmod/modprobe.conf
	
	docinto modutils-${MODUTILS_PV}
	dodoc COPYING CREDITS ChangeLog NEWS README TODO

	cd ${S}
	# This copies the old version of modutils to *.old so it still works
	# with kernels <= 2.4
	# This code was borrowed from the module-init-tools Makefile
	for f in lsmod modprobe rmmod depmod insmod; do
		if [ -L ${D}/sbin/${f} ]; then
			ln -sf `ls -l ${D}/sbin/${f} | \
				sed 's/.* -> //'`.old ${D}/sbin/${f};
		fi;
		mv ${D}/sbin/${f} ${D}/sbin/${f}.old;
	done
#	make prefix=${D} move-old-targets || die "Renaming old bins to *.old failed"

	einstall prefix=${D}

	# Install the modules.conf2modprobe.conf tool, so we can update
	# modprobe.conf.
	into /
	dosbin ${S}/generate-modprobe.conf

	# Create the new modprobe.conf
	dodir /etc

# This we should rather do in pkg_postinst(), else we confuse modules-update ...
#	if [ -f /etc/modules.conf ]; then
#		einfo "Generating /etc/modprobe.conf ..."
#		PATH="${D}/sbin:${PATH}" \
#		${S}/generate-modprobe.conf ${D}/etc/modprobe.conf \
#			|| die "Could not create modprobe.conf"
#	fi
	rm -f ${D}/etc/modprobe.conf
	if [ ! -f ${ROOT}/etc/modprobe.devfs ]; then
		# Support file for the devfs hack .. needed else modprobe borks.
		# Baselayout-1.8.6.3 or there abouts will have a modules-update that
		# will correctly generate /etc/modprobe.devfs ....
		echo "### This file is automatically generated by modules-update" \
			> ${D}/etc/modprobe.devfs
	else
		# This is dynamic, so we do not want this in the package ...
		rm -f ${D}/etc/modprobe.devfs
	fi

	docinto
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]; then
		einfo "Updating config files..."
		if [ -x /sbin/modules-update ]; then
			/sbin/modules-update
			
		elif [ -x /sbin/update-modules ]; then
			/sbin/update-modules

		elif [ -x /usr/sbin/update-modules ]; then
			/usr/sbin/update-modules
		fi
	fi
	# Notify user of evilness, hope for a better way ;-)
	echo ""
 	einfo "This overwrites the modutils files, so if you remove this,"
 	einfo "remember to remerge modutils.  However, this package has"
 	einfo "installed a copy of the modutils files with suffix .old"
 	einfo "in your /sbin directory, which will automatically be used"
	einfo "when needed."
	echo ""
}



pkg_postrm() {
	if [ "$(best_version ${PN})" == "${CATEGORY}/${PF}" -a ! -f /sbin/insmod ]; then
		ewarn "Uninstalling module-init-tools has left you"
		ewarn "without a modutils installtion. we recommend"
		ewarn "emerging modutils immediately or remerging"
		ewarn "module-init-tools."
	fi
}

