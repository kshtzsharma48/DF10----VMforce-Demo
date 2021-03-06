// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.medisend.mediaid.web;

import java.io.UnsupportedEncodingException;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.medisend.mediaid.domain.InventoryItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect InventoryItemController_Roo_Controller {
    
    @Autowired
    private GenericConversionService InventoryItemController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String InventoryItemController.create(@Valid InventoryItem inventoryItem, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("inventoryItem", inventoryItem);
            return "inventoryitems/create";
        }
        inventoryItem.persist();
        return "redirect:/inventoryitems/" + encodeUrlPathSegment(inventoryItem.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String InventoryItemController.createForm(Model model) {
        model.addAttribute("inventoryItem", new InventoryItem());
        return "inventoryitems/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String InventoryItemController.show(@PathVariable("id") String id, Model model) {
        model.addAttribute("inventoryitem", InventoryItem.findInventoryItem(id));
        model.addAttribute("itemId", id);
        return "inventoryitems/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String InventoryItemController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("inventoryitems", InventoryItem.findInventoryItemEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) InventoryItem.countInventoryItems() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("inventoryitems", InventoryItem.findAllInventoryItems());
        }
        return "inventoryitems/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String InventoryItemController.update(@Valid InventoryItem inventoryItem, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("inventoryItem", inventoryItem);
            return "inventoryitems/update";
        }
        inventoryItem.merge();
        return "redirect:/inventoryitems/" + encodeUrlPathSegment(inventoryItem.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String InventoryItemController.updateForm(@PathVariable("id") String id, Model model) {
        model.addAttribute("inventoryItem", InventoryItem.findInventoryItem(id));
        return "inventoryitems/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String InventoryItemController.delete(@PathVariable("id") String id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        InventoryItem.findInventoryItem(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/inventoryitems?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    Converter<InventoryItem, String> InventoryItemController.getInventoryItemConverter() {
        return new Converter<InventoryItem, String>() {
            public String convert(InventoryItem inventoryItem) {
                return new StringBuilder().append(inventoryItem.getName()).append(" ").append(inventoryItem.getItemNumber()).append(" ").append(inventoryItem.getCategory()).toString();
            }
        };
    }
    
    @PostConstruct
    void InventoryItemController.registerConverters() {
        conversionService.addConverter(getInventoryItemConverter());
    }
    
    private String InventoryItemController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
