ECLASS=gnustep
INHERITED="$INHERITED $ECLASS"

DESCRIPTION="Based on the gnustep eclass."

newdepend /c
newdepend dev-util/gnustep-make
newdepend dev-util/gnustep-base

getsourcedir() {
	if [ ! -d "${S}" ] ; then
		if [ -d "${WORKDIR}/${PN}" ] ; then
			S="${WORKDIR}/${PN}"
		elif [ -d "${WORKDIR}/${P}" ] ; then
			S="${WORKDIR}/${P}"
		else
			die "Cannot find source directory!"
		fi
	fi
}

need-gnustep-gui() {
	if [ "$1" ] ; then
		newdepend ">=dev-util/gnustep-gui-$1"
		RDEPEND="${RDEPEND} >=dev-util/gnustep-back-$1"
	else
		newdepend "dev-util/gnustep-gui"
		RDEPEND="${RDEPEND} dev-util/gnustep-back"
	fi
}

egnustepmake() {
	getsourcedir

	addwrite ~/GNUstep/Defaults/.GNUstepDefaults.lck
	addpredict ~/GNUstep	

	cd ${S}

	if [ -f /usr/GNUstep/System/Makefiles/GNUstep.sh ] ; then
		. /usr/GNUstep/System/Makefiles/GNUstep.sh
	else
		die "gnustep-make not installed!"
	fi

	mkdir -p $TMP/fakehome/GNUstep

	if [ -x configure ] ; then
		if [ -z "$*" ] ; then
			econf \
				HOME=$TMP/fakehome \
				GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep \
				|| die "configure failed"
		else
			econf \
				HOME=$TMP/fakehome \
				GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep \
				$* || die "configure failed (options: $*)"
		fi
	fi

	if [ ! "${GNUSTEPBACK_XFT}" -eq 2 ] ; then
		if [ "${PN}" = "gnustep-back" ] ; then
			if [ ! -f "/usr/X11R6/include/X11/Xft1/Xft.h" ]; then
				sed "s,^#define HAVE_XFT.*,#undef HAVE_XFT,g" config.h > config.h.new
				sed "s,^#define HAVE_UTF8.*,#undef HAVE_UTF8,g" config.h.new > config.h
				sed "s,^WITH_XFT=.*,WITH_XFT=no," config.make > config.make.new
				sed "s,-lXft,," config.make.new > config.make
			fi
		fi
	fi
	
	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		make \
			HOME=$TMP/fakehome \
			GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep \
			|| die "emake failed"
	else
		die "no Makefile found"
	fi
	return 0
}

egnustepinstall() {
	getsourcedir

	addwrite ~/GNUstep/Defaults/.GNUstepDefaults.lck
	addpredict ~/GNUstep	

	cd ${S}
	
	if [ -f /usr/GNUstep/System/Makefiles/GNUstep.sh ] ; then
                source /usr/GNUstep/System/Makefiles/GNUstep.sh
        else
                die "gnustep-make not installed!"
        fi

	mkdir -p $TMP/fakehome/GNUstep

	if [ -f ./[mM]akefile -o -f ./GNUmakefile ] ; then
		# To be or not to be evil?
		# Should all the roots point at GNUSTEP_SYSTEM_ROOT to force
		# install?
		# GNUSTEP_USER_ROOT must be GNUSTEP_SYSTEM_ROOT, some malformed
		# Makefiles install there. 
		if [ "${PN}" = "gnustep-base" ] || [ "${PN}" = "gnustep-gui" ] || [ "${PN}" = "gnustep-back" ] ; then
			# for some reason, they need less tending to...
			make \
				GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep \
				HOME=$TMP/fakehome \
				GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
				INSTALL_ROOT_DIR=${D} \
				install || die "einstall failed"
		else 
			make \
				GNUSTEP_USER_ROOT=$TMP/fakehome/GNUstep \
				HOME=$TMP/fakehome \
        	        	GNUSTEP_INSTALLATION_DIR=${D}${GNUSTEP_SYSTEM_ROOT} \
                		INSTALL_ROOT_DIR=${D} \
				GNUSTEP_LOCAL_ROOT=${D}${GNUSTEP_LOCAL_ROOT} \
				GNUSTEP_NETWORK_ROOT=${D}${GNUSTEP_NETWORK_ROOT} \
				GNUSTEP_SYSTEM_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
				GNUSTEP_USER_ROOT=${D}${GNUSTEP_SYSTEM_ROOT} \
		 		install || die "einstall failed"
		fi
	else
		die "no Makefile found" 
	fi
	return 0
}

gnustep_src_compile() {
	egnustepmake || die
}

gnustep_src_install() {
	egnustepinstall || die
}

EXPORT_FUNCTIONS src_compile src_install
